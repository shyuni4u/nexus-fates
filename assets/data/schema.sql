create table users (
  id uuid primary key default uuid_generate_v4(),  -- Supabase Auth의 user.id와 동일
  email text unique,                                -- 이메일 로그인 사용자용
  display_name text,                                -- 닉네임 또는 표시명
  auth_provider text not null default 'anonymous',  -- 로그인 방식 (anonymous, email, google 등)
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table readings (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references users(id) on delete cascade,  -- 리딩 사용자
  question text not null,                               -- 사용자 질문
  cards jsonb not null,                                 -- 뽑은 카드 배열 (예: [{position:1, card:"The Fool", reversed:false}, ...])
  spread_type text not null default 'celtic_cross',     -- 스프레드 유형 (확장성 고려)
  ai_interpretation text,                               -- Gemini AI 해석 결과
  created_at timestamptz default now()
);

create table subscriptions (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references users(id) on delete cascade,
  platform text not null,                    -- 'google' 또는 'apple'
  product_id text not null,                  -- 인앱 결제 상품 ID
  status text not null,                      -- 'active', 'expired', 'canceled'
  start_date timestamptz not null,
  end_date timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table readings enable row level security;
create policy "Users can access own readings" 
on readings for all 
using (auth.uid() = user_id);
