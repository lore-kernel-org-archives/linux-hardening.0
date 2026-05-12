Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B13451B3
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597132; cv=none; b=Mi5+imkDaIWJ7BpVQZr2lkF2OeSNzYqVgb8bPc89FmWrdURNLwrK4YeRYA67UYEEK/IFLZ7xxLrpcKM23UmwsjSesbxIvPactPRabkCEBnB+3L21YqawV/QASkhOeSKS6qqtVJQlvMAp8ZhvTWtmJ8KI7XJS/qC5LwQA2kq41Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597132; c=relaxed/simple;
	bh=bmsER1YMs1gTkuW0uC3C0cqMRvz8G154HC4Em56qNGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaipWWWsOErQw0BwU4AopFs8XYslgA7a1nSEv38Vt3bb0oxuMMsQbZIw8JMe4p1Ed+nRmNuZfbELm+QGGbgDHJ4N6us90IPLAoimnxuWVQ3Y5/WH82JGgzLQd67GqW9MPnNYx2Z4lChxGgDBOCFFog9t5BlTVWpjvJCV0Ji3mIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6VORTnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6VORTnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5657C2BD00
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597131;
	bh=bmsER1YMs1gTkuW0uC3C0cqMRvz8G154HC4Em56qNGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g6VORTnVqhl5m3rCTNfKS3DCc1oZXhJcR8wMKqUTRTtA6xdvP2zRNnCkdJkbC4yJ/
	 ns2GLvRAzP+1A+S+JyEVLHw+yPNzmgISjJurI6z9Z2/yYff1oi0cLxkgk1E+F2JZY/
	 ZtexpG4Jc3OiMKg+wIpe8+lFRKvcokjc6Poa2HLPnzR7xDxpLxt807AXTj25PsfQWj
	 zcvwSIiVBCoRao6AXS2/b939jcTEArD5Y+tPSv2oag74mW+zK5+/wVB0OllEhXdYUd
	 xt++IlRRgJmvGVSeABDqyWC91BKPKHdNWV4QrjPi8ajH0y4k8R/dbS+8uDw7If6B/y
	 Xmmp2GTX/M3dg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so3981340a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 07:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9eAl4c7D2m8iGE4eIM0SQRiobGlIkgBos8OJbRoUkwBFY7WQrTI6P5ob7w/nUvYAt7Q1m6c88LNP/zo6AKKlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+ThfW7gLqgQPc6gqU8uX0m5llg9dR+5MnaH3/uj/dhk8LL90
	a995/vy8GFLYEzs/h7Dq7n4O+9/We8mZuzvb1BLmvt2uj9ZiYWlGTDGiwCnoNRxyh94yaK5HLhA
	GlRkH6Q4PTYqOSKhveGoBidWW3ZpEPw==
X-Received: by 2002:a17:907:960f:b0:bc1:36dd:c6cb with SMTP id
 a640c23a62f3a-bd28f090142mr220413366b.20.1778597130173; Tue, 12 May 2026
 07:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306163658.2741860-2-robh@kernel.org> <f4b64049-e7f4-4d96-84f2-e8dac2cf5322@igalia.com>
In-Reply-To: <f4b64049-e7f4-4d96-84f2-e8dac2cf5322@igalia.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 May 2026 09:45:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLyZ0mtj-i6sOS9rccdc73QGcJt44Tx9jfR8f=eGX--dg@mail.gmail.com>
X-Gm-Features: AVHnY4KwfkGSXiHGcLCxO2Rmh74JFZ_heUlga50LQiqSzhP9b7tpTqZ7rodLb_c
Message-ID: <CAL_JsqLyZ0mtj-i6sOS9rccdc73QGcJt44Tx9jfR8f=eGX--dg@mail.gmail.com>
Subject: Re: [PATCH] accel: ethosu: Add performance counter support
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 1:46=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com>=
 wrote:
>
> Hi Rob,

Thanks for the review Ma=C3=ADra!

> On 06/03/26 13:36, Rob Herring (Arm) wrote:
> > The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> > supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> > different events. There is also a dedicated cycle counter.
> >
> > The ABI and implementation are copied from the V3D driver. The main
>
> I'm planning to send a series fixing some perfmon locking issues in the
> V3D driver later this week. But, to give you a brief summary of the main
> issues:
>
> 1. The active perfmon is not protected against races (run_job() vs.
> IOCTLs).
>
> 2. ethosu_switch_perfmon() only starts/stops the perfmon in run_job().
> This means that if nothing is further queued up, a perfmon will never
> actually be stopped.

For ethosu, other than idle and cycle counts, nothing else counts when
a job is done. Idle is just the time from enabling the counter to
start a job and then from the job stopping to reading the counters.
IOW, the idle count while a job is running is 0 and
idle+active=3Dcycles.


> More comments inline:
>
> > difference in the ABI is there is no query API for the the event list.
> > The events differ between the U65 and U85, so the events lists are
> > maintained in userspace along with other differences between the U65 an=
d
> > U85.
> >
> > The cycle counter is always enabled when the PMU is enabled. When the
> > user requests N events, reading the counters will return the N events
> > plus the cycle counter.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > MR for mesa with initial support is here:
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40269
> >
> >   drivers/accel/ethosu/Makefile         |   2 +-
> >   drivers/accel/ethosu/ethosu_device.h  |  21 ++
> >   drivers/accel/ethosu/ethosu_drv.c     |  17 +-
> >   drivers/accel/ethosu/ethosu_drv.h     |  62 ++++++
> >   drivers/accel/ethosu/ethosu_job.c     |  35 +++-
> >   drivers/accel/ethosu/ethosu_job.h     |   2 +
> >   drivers/accel/ethosu/ethosu_perfmon.c | 282 +++++++++++++++++++++++++=
+
> >   include/uapi/drm/ethosu_accel.h       |  59 +++++-
> >   8 files changed, 469 insertions(+), 11 deletions(-)
> >   create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c
> >
>
> [...]
>
> > diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/e=
thosu_drv.h
> > index 9e21dfe94184..57eee79e4b83 100644
> > --- a/drivers/accel/ethosu/ethosu_drv.h
> > +++ b/drivers/accel/ethosu/ethosu_drv.h
> > @@ -3,13 +3,75 @@
> >   #ifndef __ETHOSU_DRV_H__
> >   #define __ETHOSU_DRV_H__
> >
> > +#include <linux/idr.h>
> > +#include <linux/mutex.h>
> >   #include <drm/gpu_scheduler.h>
> >
> >   struct ethosu_device;
> > +struct drm_device;
> > +struct drm_file;
> >
> >   struct ethosu_file_priv {
> >       struct ethosu_device *edev;
> >       struct drm_sched_entity sched_entity;
> > +
> > +     struct {
> > +             struct idr idr;
>
> You may want to consider moving to XArray as we did in V3D [1].

Okay. I'll have to study that some. I still don't have my head around XArra=
y...

>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0a5b0d095bcdb219348ed8ae1c97ee99fc4913b8
>
> > +             struct mutex lock;
> > +     } perfmon;
> > +};
> > +
> > +/* Performance monitor object. The perform lifetime is controlled by u=
serspace
> > + * using perfmon related ioctls. A perfmon can be attached to a submit=
_cl
> > + * request, and when this is the case, HW perf counters will be activa=
ted just
> > + * before the submit_cl is submitted to the GPU and disabled when the =
job is
> > + * done. This way, only events related to a specific job will be count=
ed.
> > + */
> > +struct ethosu_perfmon {
> > +     /* Tracks the number of users of the perfmon, when this counter r=
eaches
> > +      * zero the perfmon is destroyed.
> > +      */
> > +     refcount_t refcnt;
> > +
> > +     /* Protects perfmon stop, as it can be invoked from multiple plac=
es. */
> > +     struct mutex lock;
>
> I'm not familiar with the Ethos hardware, but *if* it has only a single
> performance monitor active in HW at any given moment (like v3d), this
> lock doesn't enforce this restriction.
>
> This lock only serializes start/stop of *one* perfmon object against
> itself, but the invariant (at least on v3d) that needs protection is
> device-wide: there is exactly one active perfmon at any moment in HW.

You mean V3D has 1 perfmon shared among its 3? h/w queues? We only
have 1 queue. We only touch the perfmon when we touch the h/w to
run/end a job, so the same serialization for the job accesses should
cover the PMU accesses.

Rob
