CREATE TABLE public.stg_courses (
	id varchar(50) NOT NULL,
	title varchar(50) NULL,
	description varchar(1000) NULL,
	"publishedAt" timestamp NULL,
	loaded_at timestamp NULL DEFAULT now(),
	CONSTRAINT stg_courses_pkey PRIMARY KEY (id)
);