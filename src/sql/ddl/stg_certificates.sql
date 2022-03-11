CREATE TABLE public.stg_certificates (
	course varchar(50) NULL,
	"user" varchar(50) NULL,
	"completedDate" timestamp NULL,
	"startDate" timestamp NULL,
	loaded_at timestamp NULL DEFAULT now()
);