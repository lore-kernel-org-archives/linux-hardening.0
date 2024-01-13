Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2FEAD6
	for <linux-hardening@vger.kernel.org>; Sat, 13 Jan 2024 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjMqfJdV"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-595b3644acbso3428040eaf.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Jan 2024 20:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705121524; x=1705726324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRzVjE/60hfoJmBpHx7JmI7NVqzyKuJ6EGRYVVIYHyE=;
        b=UjMqfJdV8x7S+D4gIOJebINqm1UTCTvejoRiAJ1qA3bqWpGcYb2IRBxK0GNdDJvvVV
         N2QHNk/UqxXbzcfkRkeJoKB1yRgKapI9IaWA9tD6ROo3ZY9716wDJK4Q/PKXvjvbAov6
         OnY35t8wVpCfzOxQq/XjC88dBDXwp0+xNw4WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705121524; x=1705726324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRzVjE/60hfoJmBpHx7JmI7NVqzyKuJ6EGRYVVIYHyE=;
        b=t1E98KWEC18ukaEmEM/DXdgdiE65d2MSF4O3TqeJMAv8a+JxryFflrD1hlsPV+5TLY
         BzqFI6PPQy/FqiDtzaH5qUaINyFquio/B/60l9R4UOdA8rn48JcOS6ovC8fzfNI9GmxU
         tQhrb6z/M9rCYf38Cyz4etg4qm09bWricGMIdXfUgLYCK40vtZYZOBFYLGV2Gj5LuGPh
         SzcU5T31wAjYTA4V0vpFQTL0jUibFEe+0Rfj/MWOaLlqxT1JtqPhXXujlUMwL2kIAeGZ
         /n8fj6dlW8bqpbbykUEsdc+ha8sxQnZ+JhcFl3iQFAH+FgADfyaHVyBKS0IO62ULbTAJ
         1waA==
X-Gm-Message-State: AOJu0YzLu+N/6yXQArAnxKTZTMZk7Fti+3qsLiNeGUPirGKOUz3fvVpN
	EhpvbWZtkufYhGM/VZp5VHW14ZrZyc+goApzrY6Oo7+JJCqs
X-Google-Smtp-Source: AGHT+IEdaiJcCRLapVikT9wJgN0tDnSDzzD4ce1+B39OTXVVa6pay9HsBvUgQn35yTvGDp6kcRfdFxzZi0JF2T7blZk=
X-Received: by 2002:a05:6808:2092:b0:3bd:646d:4366 with SMTP id
 s18-20020a056808209200b003bd646d4366mr816782oiw.19.1705121524684; Fri, 12 Jan
 2024 20:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <20240111234142.2944934-5-jeffxu@chromium.org>
 <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
In-Reply-To: <8cb16dfe-993e-4c41-b1fe-63bc7ac97609@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 12 Jan 2024 20:51:53 -0800
Message-ID: <CABi2SkWdp5UpKmrWV5Y-v_XTVWJvhxq0nSXmK9jV2UDUXLWFyA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mseal:add documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 5:10=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Jeff,
>
>
> On 1/11/24 15:41, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 181 ++++++++++++++++++++++++++
> >  1 file changed, 181 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mseal.rst
> >
>
> To prevent the following documentation build warning:
>
> linux-next-20240112/Documentation/userspace-api/mseal.rst: WARNING: docum=
ent isn't included in any toctree
>
> please add the following to your patch 4/4:
>
OK. will do.


> diff -- a/Documentation/userspace-api/index.rst b/Documentation/userspace=
-api/index.rst
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -23,6 +23,7 @@ place where this information is gathered
>     ebpf/index
>     ELF
>     ioctl/index
> +   mseal
>     iommu
>     iommufd
>     media/index
>
> --
> #Randy
