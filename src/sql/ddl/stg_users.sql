CREATE TABLE public.stg_users (
	id text NULL,
	email text NULL,
	"firstName" text NULL,
	"lastName" text NULL,
    loaded_at timestamp NULL DEFAULT now(),
    CONSTRAINT stg_users_pkey PRIMARY KEY (id)
);