Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530713BFE34
	for <linux-hardening@vger.kernel.org>; Tue,  5 May 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003152; cv=pass; b=NzCWYV38mO9/+3blKzwDIoNezARLApoqL0uGN/XFgJrgGk3xXV5E3zMarY0OfnWfv5b/DPl2o40JCpal00bLyyx8a3WMown77lzk2zslAGWodnqHz4RrTyQGMAqfN3omVw+SYNMumfccjHYPXBehjZxP0THuyvKX1IylVAtmVPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003152; c=relaxed/simple;
	bh=tsgo89jNZ68b6p2RDyRpLC/DaB8dEVeRpSGEOeeG3G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjCjjUGRDfUHlkkfIE+pErJvB/xGj9f93Uq9gUXAeHehOrWTjNaXVIKeDD30uIzqWUYQaRmc72iY2zsuswRgJPRulYNEKNMqV0foMVCnnDDWZAb9FaB0JypiTQth28bqcCaaAp8z6NJn11oigtKRk3pxqBjOo22UUmxCORLNm+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b=GuTMDvtC; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="GuTMDvtC"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-62f31e86bfbso75659137.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 May 2026 10:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778003149; cv=none;
        d=google.com; s=arc-20240605;
        b=QMeFsULzf4iySggJZlMMCf+Q/a9lrdZ2XpKOota9KC1B+0C2sj9TKKki2/7Og5QZBg
         w0w63upSoytIYcqmVk38/AYlfjuIllnM0zazE0ggMX8BGe1ytEW3ihr5HSVofwWSVObD
         PkxTsvsQmADdIwJN/gP+TdL78qJM3vwRGX8FttA2xFW6SafChZ1wzo8bnXrd6/uuU5kA
         R2+Rvet5G4YoHa/jo7Dshp6/exg/ibqNqUpjtdqmly/uwicXrzSkHVql16hcFAcfRaRu
         D1lFsTC/Sr9f4XoZTsyftgTOdIHeijJlHbv3Y8j/UkF0G3owJHGHidIOJl8Sl9IqbviK
         AsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hmZ3nDqeDExQJSNMJTyHpyr8eUa2AAYnNivoPeEVhIw=;
        fh=35NtybSCCgvNdLdndk0DAa7PZSEeIlkJi+XyM8dvawM=;
        b=lsNT5VcFJRvlbwYPYOFncmDqOvvjyFHHWROGLK6gJQGDFgvAlm+CEQohctAAAebawW
         T7UaYRElsNJNXYzGIfETqvTQY4T97k5AFFJX3UP90ZhJGMLOY9L5zbNHspjZLK4KSdGv
         n4wf0vG/8yeqmRTY330Mw+J255h7TeJNvPkeOSVc0e/MAcArvZdNG/B+Y+AI0WSPudBm
         hInps63Tyq2PbhzOWYGPMZM64zugsPGPu19eTRb4uMIn90Rn+xOjUECNocOhQWlswBQE
         F+S1uAYeaZ1XQhP/9KMpPIebgOxhJpxZezuhxzBmJfJX/BAi8HNiThz0BlL/HqCiiQ1v
         YrIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1778003149; x=1778607949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmZ3nDqeDExQJSNMJTyHpyr8eUa2AAYnNivoPeEVhIw=;
        b=GuTMDvtCshMpgggLVZcSCNJwftomQ25PlklAy+AakAXaiZn7DIIAdcjyq1IERZKe05
         tCNZw1hWFkZENb80XqXtTrWLJHRepBJQwKGdWyCQKyQn3CYr1vJZY2IVJI+rySUCkjHd
         tq28rhdveKh4MmclDoDNg2PaHa8JglicIo35ODuLY2hTaDRbhB74UN3D4HbkO8jHS/Yo
         UsP2CafzfCVd9lA79/aarruQmbges410gP18f1SRrFQgohffrIzGuwGayJTIvDkHp+Sn
         8k1uaUXN3HMKu+BWqZL1oVrmPLCtSDMMSMvp6YpnKad81TQVNI+Mx9FbicBiBmolGdqp
         x0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003149; x=1778607949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmZ3nDqeDExQJSNMJTyHpyr8eUa2AAYnNivoPeEVhIw=;
        b=FOa+uFTmP5a+JGvyprhloWtSG1BnoIl1WWgD7bzfWYuAkEXz3RmzHF2d6PyT6NRmqm
         YvzN95n9zeSLw/Pyo/ZXbY7oV0vGU/c3lmTzuuG7NsebA/QuZcKedUOuEmleTow8j67l
         5RUDeGCXO56LmrhoQDzbFYRBQ18kS+uUHv5KkYToo/GyzznT1KdHOBQe9PkEu6fNIZ4y
         xTU/2Vs903moThCmporA4rVqO7OlEOOuTiAA+hltaVRKOgVUhuuRNiQTDSuTVF389mdG
         OpsKDu/hjH+YVDRqCmhsTzN10jMG4nWJQ+wKtXZOOSMgeWVvOfiEFqIGM7/S4Ub0Wder
         VkIg==
X-Forwarded-Encrypted: i=1; AFNElJ+Is5ji8l75HAEHxas+t3zXue0iA0Qlt7c8+L1+EZIVd9re3uGYNkaH9LtYSYkg9ctdvU1bR7Ud/87co6M3PQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzuLQ3w5FWX27ea4i1Oo1UsT8GNe4KkFbjJSgsOTn+KVLKvNK
	4iJ2WLlSLvO07Eibj8+AlVjvK4CHcgRfeffVYW5UIJFLF9Ln2daFDkd3mFjmiafJMpZRrOqBPWc
	sdzb7sG0TlJWge4CEvzi2p2AOTxiSK9sYRY6Rqhj9wA==
X-Gm-Gg: AeBDieuHmBDreXu9dS9pAmuAu5HAKxEMR9hbMs9FQdLG+9U2aGWnntqDVmna2SFhX9A
	cGo2tPzRAJmH9EUB4S1tzxmw2dGCnxrdmc5ueM3u4Fw7xB2KhPpY8nsj0/I4oKli7IBUK0ivLWO
	Rum62XSeRjl84L5VQ9MtZ2RC65xg0lzGG6lm9DhYtw6O9cKBbbYXE35dTRXybVY+f1R8QNV8KgH
	0TT5jr5BOOb+YKCtMLWEz6vGmh9uKV33+/tZ8iEgthMNJ3ZxuT9krvY3rvqbqU3pDYWzMI0eGVP
	YKueumbncYrU6aFi7A==
X-Received: by 2002:a05:6102:688f:b0:60f:b19b:e52c with SMTP id
 ada2fe7eead31-62f55a12512mr2523351137.17.1778003148995; Tue, 05 May 2026
 10:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306163658.2741860-2-robh@kernel.org>
In-Reply-To: <20260306163658.2741860-2-robh@kernel.org>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 5 May 2026 19:45:35 +0200
X-Gm-Features: AVHnY4Letji3hBYAMx1BxULT-fxmkVkmwMfiiE8fbZYo1Qh4xAyZ5plOyGKGyIU
Message-ID: <CAPsqS2SVm=LruoyAaBUyEBkDuP1Bv1=a4t=Oucx+jwGTk9CCXQ@mail.gmail.com>
Subject: Re: [PATCH] accel: ethosu: Add performance counter support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Mar 6, 2026 at 5:38=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> different events. There is also a dedicated cycle counter.
>
> The ABI and implementation are copied from the V3D driver. The main
> difference in the ABI is there is no query API for the the event list.
> The events differ between the U65 and U85, so the events lists are
> maintained in userspace along with other differences between the U65 and
> U85.
>
> The cycle counter is always enabled when the PMU is enabled. When the
> user requests N events, reading the counters will return the N events
> plus the cycle counter.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

<snip>

>
>  struct ethosu_file_priv {
>         struct ethosu_device *edev;
>         struct drm_sched_entity sched_entity;
> +
> +       struct {
> +               struct idr idr;
> +               struct mutex lock;
> +       } perfmon;
> +};
> +
> +/* Performance monitor object. The perform lifetime is controlled by use=
rspace
> + * using perfmon related ioctls. A perfmon can be attached to a submit_c=
l

I guess submit_cl is more of a v3d thing?

> + * request, and when this is the case, HW perf counters will be activate=
d just
> + * before the submit_cl is submitted to the GPU and disabled when the jo=
b is
> + * done. This way, only events related to a specific job will be counted=
.
> + */
> +struct ethosu_perfmon {
> +       /* Tracks the number of users of the perfmon, when this counter r=
eaches
> +        * zero the perfmon is destroyed.
> +        */
> +       refcount_t refcnt;
> +
> +       /* Protects perfmon stop, as it can be invoked from multiple plac=
es. */
> +       struct mutex lock;
> +
> +       /* Number of counters activated in this perfmon instance
> +        * (should be less than or equal to DRM_ETHOSU_MAX_PERF_COUNTERS)=
.
> +        */
> +       u8 ncounters;
> +
> +       /* Events counted by the HW perf counters. */
> +       u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> +
> +       /* Storage for counter values. Counters are incremented by the
> +        * HW perf counter values every time the perfmon is attached
> +        * to a GPU job.  This way, perfmon users don't have to
> +        * retrieve the results after each job if they want to track
> +        * events covering several submissions.  Note that counter
> +        * values can't be reset, but you can fake a reset by
> +        * destroying the perfmon and creating a new one.
> +        */
> +       u64 values[] __counted_by(ncounters);
>  };

<snip>

> +void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_pe=
rfmon *perfmon)
> +{
> +       unsigned int i;
> +       u8 ncounters;
> +       u32 mask;
> +
> +       if (WARN_ON_ONCE(!perfmon || ethosu->active_perfmon))
> +               return;
> +
> +       writel_relaxed(PMCR_CNT_EN, ethosu->pmu_regs + NPU_REG_PMCR);
> +       writel_relaxed(0x000011, ethosu->pmu_regs + NPU_REG_PMCCNTR_CFG);

Can we use macros for this value so we have it documented in the source cod=
e?

<snip>

> +void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_per=
fmon *perfmon,
> +                     bool capture)
> +{
> +       unsigned int i;
> +       u8 ncounters;
> +       u32 mask;
> +
> +       if (!perfmon || !ethosu->active_perfmon)
> +               return;
> +
> +       mutex_lock(&perfmon->lock);
> +       if (perfmon !=3D ethosu->active_perfmon) {
> +               mutex_unlock(&perfmon->lock);
> +               return;
> +       }
> +
> +       ncounters =3D perfmon->ncounters - 1;
> +
> +       if (capture) {
> +               for (i =3D 0; i < ncounters; i++)
> +                       perfmon->values[i] +=3D readl_relaxed(ethosu->pmu=
_regs + NPU_REG_PMU_EVCNTR(i));
> +               perfmon->values[ncounters] +=3D
> +                       readl_relaxed(ethosu->pmu_regs + NPU_REG_PMCCNTR_=
LO) |
> +                       (u64)readl_relaxed(ethosu->pmu_regs + NPU_REG_PMC=
CNTR_HI) << 32;
> +       }
> +
> +       mask =3D 0x80000000;
> +       if (ncounters)
> +               mask |=3D GENMASK(ncounters - 1, 0);
> +       writel_relaxed(mask, ethosu->pmu_regs + NPU_REG_PMCNTENCLR);
> +
> +       writel_relaxed(0, ethosu->pmu_regs + NPU_REG_PMCR);
> +       ethosu->active_perfmon =3D NULL;
> +       mutex_unlock(&perfmon->lock);

Wonder if the npu-idle counter won't continue to accumulate until we
call stop(), and in that case, if we shouldn't stop the counters on
the job IRQ. So we can know for how long the NPU was idle during the
job, without extra idle time.

I think we could freeze the counters in the job_done IRQ, and harvest
the values on job cleanup. At freeze time it would be good to also
capture a timestamp and return to userspace in get_values, so that
userspace doesn't have to take it with considerable delay (for tools
such as Perfetto).

<snip>

> +int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
> +                            struct drm_file *file_priv)
> +{
> +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
> +       struct drm_ethosu_perfmon_create *req =3D data;
> +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> +       struct ethosu_perfmon *perfmon;
> +       unsigned int i, event_max;
> +       int ret;
> +
> +       /* Number of monitored counters cannot exceed HW limits. */
> +       if (req->ncounters > ethosu->npu_info.pmu_counters)
> +               return -EINVAL;
> +
> +       /* Make sure all counters are valid. */
> +       event_max =3D ethosu_is_u65(ethosu) ? 433 : 671;

Can we have macros for these constants?

<snip>

> +int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
> +                                struct drm_file *file_priv)
> +{
> +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
> +       struct drm_ethosu_perfmon_get_values *req =3D data;
> +       struct ethosu_perfmon *perfmon;
> +       int ret =3D 0;
> +
> +       if (req->pad !=3D 0)
> +               return -EINVAL;
> +
> +       perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);
> +       if (!perfmon)
> +               return -EINVAL;
> +
> +       ret =3D pm_runtime_resume_and_get(dev->dev);
> +       if (ret)

Should we cal put() here?

> +               return ret;
> +
> +       ethosu_perfmon_stop(ethosu, perfmon, true);
> +
> +       pm_runtime_put_autosuspend(dev->dev);
> +
> +       if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->value=
s,
> +                        perfmon->ncounters * sizeof(u64)))

And here?

> +               ret =3D -EFAULT;
> +
> +       ethosu_perfmon_put(perfmon);
> +
> +       return ret;
> +}
> +
> +int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
> +                                struct drm_file *file_priv)
> +{
> +       struct ethosu_file_priv *ethosu_priv =3D file_priv->driver_priv;
> +       struct drm_ethosu_perfmon_set_global *req =3D data;
> +       struct ethosu_device *ethosu =3D to_ethosu_device(dev);
> +       struct ethosu_perfmon *perfmon;
> +
> +       if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
> +               return -EINVAL;
> +
> +       perfmon =3D ethosu_perfmon_find(ethosu_priv, req->id);

Aren't we leaking this second reference?

Thanks!

Tomeu

> +       if (!perfmon)
> +               return -EINVAL;
> +
> +       /* If the request is to clear the global performance monitor */
> +       if (req->flags & DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
> +               if (!ethosu->global_perfmon)
> +                       return -EINVAL;
> +
> +               xchg(&ethosu->global_perfmon, NULL);
> +
> +               return 0;
> +       }
> +
> +       if (cmpxchg(&ethosu->global_perfmon, NULL, perfmon))
> +               return -EBUSY;
> +
> +       return 0;
> +}
> diff --git a/include/uapi/drm/ethosu_accel.h b/include/uapi/drm/ethosu_ac=
cel.h
> index af78bb4686d7..dde6756642ea 100644
> --- a/include/uapi/drm/ethosu_accel.h
> +++ b/include/uapi/drm/ethosu_accel.h
> @@ -43,6 +43,11 @@ enum drm_ethosu_ioctl_id {
>
>         /** @DRM_ETHOSU_SUBMIT: Submit a job and BOs to run. */
>         DRM_ETHOSU_SUBMIT,
> +
> +       DRM_ETHOSU_PERFMON_CREATE,
> +       DRM_ETHOSU_PERFMON_DESTROY,
> +       DRM_ETHOSU_PERFMON_GET_VALUES,
> +       DRM_ETHOSU_PERFMON_SET_GLOBAL,
>  };
>
>  /**
> @@ -79,6 +84,7 @@ struct drm_ethosu_npu_info {
>         __u32 config;
>
>         __u32 sram_size;
> +       __u32 pmu_counters;
>  };
>
>  /**
> @@ -220,8 +226,51 @@ struct drm_ethosu_submit {
>         /** Input: Number of jobs passed in. */
>         __u32 job_count;
>
> -       /** Reserved, must be zero. */
> +       /** Input: Id returned by DRM_ETHOSU_PERFMON_CREATE */
> +       __u32 perfmon_id;
> +};
> +
> +#define DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS     8
> +#define DRM_ETHOSU_MAX_PERF_COUNTERS \
> +       (DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS + 1)
> +
> +struct drm_ethosu_perfmon_create {
> +       __u32 id;
> +       __u32 ncounters;
> +       __u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> +};
> +
> +struct drm_ethosu_perfmon_destroy {
> +       __u32 id;
> +};
> +
> +/*
> + * Returns the values of the performance counters tracked by this
> + * perfmon (as an array of (ncounters + 1) u64 values).
> + *
> + * No implicit synchronization is performed, so the user has to
> + * guarantee that any jobs using this perfmon have already been
> + * completed.
> + */
> +struct drm_ethosu_perfmon_get_values {
> +       __u32 id;
>         __u32 pad;
> +       __u64 values_ptr;
> +};
> +
> +#define DRM_ETHOSU_PERFMON_CLEAR_GLOBAL    0x0001
> +
> +/**
> + * struct drm_ethosu_perfmon_set_global - ioctl to define a global perfo=
rmance
> + * monitor
> + *
> + * The global performance monitor will be used for all jobs. If a global
> + * performance monitor is defined, jobs with a self-defined performance
> + * monitor won't be allowed.
> + */
> +struct drm_ethosu_perfmon_set_global {
> +       __u32 flags;
> +       __u32 id;
>  };
>
>  /**
> @@ -252,6 +301,14 @@ enum {
>                 DRM_IOCTL_ETHOSU(WR, CMDSTREAM_BO_CREATE, cmdstream_bo_cr=
eate),
>         DRM_IOCTL_ETHOSU_SUBMIT =3D
>                 DRM_IOCTL_ETHOSU(WR, SUBMIT, submit),
> +       DRM_IOCTL_ETHOSU_PERFMON_CREATE =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_CREATE, perfmon_create),
> +       DRM_IOCTL_ETHOSU_PERFMON_DESTROY =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_DESTROY, perfmon_destroy),
> +       DRM_IOCTL_ETHOSU_PERFMON_GET_VALUES =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_GET_VALUES, perfmon_get_valu=
es),
> +       DRM_IOCTL_ETHOSU_PERFMON_SET_GLOBAL =3D
> +               DRM_IOCTL_ETHOSU(WR, PERFMON_SET_GLOBAL, perfmon_set_glob=
al),
>  };
>
>  #if defined(__cplusplus)
> --
> 2.51.0
>
