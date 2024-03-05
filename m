Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716A12AAEB
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672286; cv=none; b=hz9edoTK20YUN8m1Ed5cogaKvk35XqMxBDSi+t73yEqSEgujzUNfmBxKuWDEImneb/xpnO5x+6q9Tdjec9IC2jtWt8JIHIt25AXH+MHQYI9uoRQdbYqS/ciX8hfVsuYWSMfWufHMHzY0plHzf0aSnmNUMlfFyChcFzSvg0PEXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672286; c=relaxed/simple;
	bh=wWG/Kgy0jS1x5qSuFdcHkkq/gavTMiUaXVlXVaHjyIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCUgzISZbQF2yG9ZattxABJPMZ6tXDqmb+4nz/ewrpPB8Dpkw7G1F4rXCr7KjFqVPs23C+/w4jVb2Rv+solqzmjKb+NrrCGAlmyjIIi8fZVk2ov/kt+8uOKSm6luQ4CD03t1YUH8rU+O1HVj1ueA0moU5Z/7mrtEFOjj75tJx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITZvfUJr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITZvfUJr"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ef8193ae6so82131cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 12:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709672283; x=1710277083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=;
        b=ITZvfUJraFd5Y8WZ0O2trYqgAs5xl8lqnJTECVALowK09cCrh1igdXQpaDBOzvMoRO
         WcPIibKjwXXeq2m7cWRpDwuqTveNL+JZtgBDSBpxVbxOO1BPPCUqn+hSYPjBlIOyCEfJ
         SgG1wfga3dAyR/5yP/Kzq/i9Vpjfn+EFwz1Qa1bFTUMsvvWQROxj8bpVBrIwgOGjxuak
         WvN275O+tmeQOvxrJGgxdUPdbMcR/J7E82VV7c88yAcfDf1TvFwclC9ExtoewAqD/pa9
         uvbPaFoekaJDVNQGCW7vOaJUqI0UrqcOiNzb7oUBaIYJ0jCyZ91IbXMfEtYQietkumQV
         q8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672283; x=1710277083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxiO4n45vzilrBo9kDMmtmLfT3QtdcOwiJ3TQqHhtUU=;
        b=alfxuJ0ggObEjrY/GKeomyq0KC5YGRfW0YVQpsYOVctXpPeM40GLO+xbOsxqRFo7kf
         /CvRcFYdCOeXkeoLPT0fwBYD9UA+V8rHOUXoXODuWBVupThU1NTQ9NCjyo6cjMR0NVqS
         jBhMSpV4cnlYy/9dXuPlwTKRMzSPexmWDOUq2VX+G+vtwrgPH9IGBejpvxUkE4r25myZ
         Ygt0i1eoVfpNLgNRdwXPTAPRxX7BnNi0X11IIA2bwVZ4WAy9byb5lNI2qys0qoge6xDw
         itcjtBmv3SFPLlLayMnUjZYK+oR1/HC3yjgalYxaqHQgzX2oPppR1NVuponBox1tnhoh
         UwtA==
X-Forwarded-Encrypted: i=1; AJvYcCVV/P8pDz2POx+qgyeMFgJtYz73YH6mggGRa+eJp1frf+gfZEUgNS3W531pW19+IjeU5U22lumIlVXrKRFw2qsk2mOnyoVvCkWVKctvRMkV
X-Gm-Message-State: AOJu0YxKjNKP3pPFrZ7mojUsDeOGpp3iOTKPTf4lzs0+RMsWIYlFViCW
	wJ12g3J9V9JCtEZ32TjR33TpdmTVtXrbDKq6fZAl7KuGiWmyNvg99KhplFyBukfw2eF3RTkA+5O
	qbhXPptWHDNX0EvpG1o2koctQuaSReasLuC+m
X-Google-Smtp-Source: AGHT+IHGajjUdBLk7kb5aU5IzN9BFfXaz7kyHr0r9Hfw9dnJJ6/Mro4cDB9qMZ+LQnnYDduac+wAa+5vLvNmFAFMPZ8=
X-Received: by 2002:a05:622a:489:b0:42e:ef12:8025 with SMTP id
 p9-20020a05622a048900b0042eef128025mr263015qtx.25.1709672283186; Tue, 05 Mar
 2024 12:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-3-mic@digikod.net>
In-Reply-To: <20240301194037.532117-3-mic@digikod.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 5 Mar 2024 15:57:51 -0500
Message-ID: <CA+GJov46__vOS9m7Jz9tw+nxd1LFh_a=g1SR=BjUzR9HT65Vew@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kunit: Fix kthread reference
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:40=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> There is a race condition when a kthread finishes after the deadline and
> before the call to kthread_stop(), which may lead to use after free.

Hello!

I have tested this patch and it looks good to me.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>




>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-3-mic@digikod.net
> ---
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index a5cb2ef70a25..73f5007f20ea 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,6 +11,7 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> +#include <linux/sched/task.h>
>
>  #include "try-catch-impl.h"
>
> @@ -65,14 +66,15 @@ void kunit_try_catch_run(struct kunit_try_catch *try_=
catch, void *context)
>         try_catch->context =3D context;
>         try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
> -       task_struct =3D kthread_run(kunit_generic_run_threadfn_adapter,
> -                                 try_catch,
> -                                 "kunit_try_catch_thread");
> +       task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
> +                                    try_catch, "kunit_try_catch_thread")=
;
>         if (IS_ERR(task_struct)) {
>                 try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> +       get_task_struct(task_struct);
> +       wake_up_process(task_struct);
>
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
> @@ -82,6 +84,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 kthread_stop(task_struct);
>         }
>
> +       put_task_struct(task_struct);
>         exit_code =3D try_catch->try_result;
>
>         if (!exit_code)
> --
> 2.44.0
>
