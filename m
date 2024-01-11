Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE424A4D
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9vfgpIm"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-204301f2934so3187803fac.1
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 18:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704941940; x=1705546740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iusV3IyQOZs3xOP+4u/FoLP2ed3pvxpbfjuW8JoG9bs=;
        b=j9vfgpImK4SrHWburcEebxx33c4qZ3HM34SDhqsD3U6lOcV+ODoYtvkQDlZJfPFTFz
         5wPTSB863fTsc539mdqLqP2TFOAYl4SV2fm7bJxB1Mu7y7zFByOz6HzvpscDfF/qQSTF
         uW7z22BOLcRTAamCMl+XlijTB14OO0oWA3mcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704941940; x=1705546740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iusV3IyQOZs3xOP+4u/FoLP2ed3pvxpbfjuW8JoG9bs=;
        b=J5GgyMQUNx7SdHJ/yU14rGmgten/Zw7qY8umPiYbJLuUj8Xa6oE8I3xjmCl95Ka+v8
         N512p55/ypcibOQwK3pnp2Keh49e8JC6z7CCkHmTB0qLpScZLlFJWxFZGCTyw4z0/LTL
         3V/V4EURo4hRCZJODKWTmT/5HZ6bkmDegMuuvA/0WKovoncNtXO+sBWEBGvlff73ZaHu
         ROAU/vrr/U04h88GfMLHlC62lPSOWyjYDxxhY0TbqGRTTVcVcqmClpcCppBp96UDP09t
         FTqY904IS2mAl+6dyZxJCWMsqhRPWvRymq+i6/8P3RAKJ7Nlx2mrDpO7lMvEOTIwHx36
         P5sA==
X-Gm-Message-State: AOJu0YwXw3K4ihzodLDbb3z+9jV1RIftXKVAEVrz8yaD50xSqJBRiryY
	AIV+A8OJ5q7DMKLh47lWrdwtQ0hBd8RMjW7b1/QZMlTPHGNC
X-Google-Smtp-Source: AGHT+IEskTSe0nGIcOItqfJ6SepvxiQWh43wQkxn0KPGgUFpEKm7ALUXSUzjdhE2a+LQiKbpeQ6rkBIhe4NhubhRI6U=
X-Received: by 2002:a05:6871:4e97:b0:205:e3bd:6920 with SMTP id
 uk23-20020a0568714e9700b00205e3bd6920mr543948oab.95.1704941939966; Wed, 10
 Jan 2024 18:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <20240109154547.1839886-3-jeffxu@chromium.org>
 <ZZ2uXyPCE+l2Uccr@casper.infradead.org>
In-Reply-To: <ZZ2uXyPCE+l2Uccr@casper.infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 10 Jan 2024 18:58:48 -0800
Message-ID: <CABi2SkVFVYWiYNCzsfFbkOW4kurysYp2X79prqoHFb488QKbYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/4] mseal: add mseal syscall
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 12:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jan 09, 2024 at 03:45:40PM +0000, jeffxu@chromium.org wrote:
> > +extern bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> > +             unsigned long end);
> > +extern bool can_modify_mm_madv(struct mm_struct *mm, unsigned long sta=
rt,
> > +             unsigned long end, int behavior);
>
> unnecessary use of extern.
>
> > +static inline unsigned long get_mmap_seals(unsigned long prot,
> > +     unsigned long flags)
>
> needs more than one tab indent so it doesn't look like part of the body.
>
> > +{
> > +     unsigned long vm_seals;
> > +
> > +     if (prot & PROT_SEAL)
> > +             vm_seals =3D VM_SEALED | VM_SEALABLE;
> > +     else
> > +             vm_seals =3D (flags & MAP_SEALABLE) ? VM_SEALABLE:0;
>
> need spaces around the :
>
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -17,6 +17,11 @@
> >  #define PROT_GROWSDOWN       0x01000000      /* mprotect flag: extend =
change to start of growsdown vma */
> >  #define PROT_GROWSUP 0x02000000      /* mprotect flag: extend change t=
o end of growsup vma */
> >
> > +/*
> > + * The PROT_SEAL defines memory sealing in the prot argument of mmap()=
.
> > + */
> > +#define PROT_SEAL    _BITUL(26)      /* 0x04000000 */
>
> why not follow the existing style?
>
> > +static inline void set_vma_sealed(struct vm_area_struct *vma)
> > +{
> > +     vma->__vm_flags |=3D VM_SEALED;
> > +}
>
> uhh ... vm_flags_set() ?
>
Thanks. I agree with all the comments above and will update in the next ver=
sion.

-Jeff
