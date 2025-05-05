Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC022617F
	for <linux-hardening@vger.kernel.org>; Mon,  5 May 2025 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446860; cv=none; b=RrEAL/rVSVRJU792txupbWGQe8oIGXtd2VBxUtMjifi0AwcH46XCgUMTchnksH6XRDPUTrpMdngoAwM2MJ9ImjfyeNR6SwKIKJyiqsSmpcvf/I7U83mnDF9eTmb4suGkrFcS6ftYbOAiPJIsxOfw3Jumg4aqCkH4BTCsAAUY1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446860; c=relaxed/simple;
	bh=OhieS/K1pVWys8cRyyoz+lJJA4aObar6rgBHhZH/SrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQC2UsLEoPAJidZHCe2b2Srr2ChV+InZDueRPMkEdde8j2bWsFYReeD1HlynYVHTl3OpJ+c7DIClZkQ0zNJP0pLVviXwdQTqhQOAfqtnLcF3tJRSFiiKWVmqoRr5m+6mKlNKks9NUV5MTWcNBNv03WmgpC2p2N3dmwnmDvB72Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kd+W/Ux0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kd+W/Ux0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476ab588f32so71606931cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 May 2025 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746446857; x=1747051657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P4QkUflIXod3XNly4g7gKrBpyN8k4MZSMEMI36uvsmU=;
        b=kd+W/Ux0e8vqfsG/e7s0OdsEKUl6QQeMdtdXyCBb1OKTedh1zg+7O+b5CmZbEO/JKB
         URs+JJUNIIV4373CVQGUsxcDU5xVFu3lyKF6DB67M/JWFMw65Biyt+3BhEAAL9Ihva4V
         Dgid6OoRUPkBAMfE8dN6uUuQ6s7ekejgHhUzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746446857; x=1747051657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4QkUflIXod3XNly4g7gKrBpyN8k4MZSMEMI36uvsmU=;
        b=sK8bIrsTMkuHcLmDaYhblKoqSoNLgAuGxpxht58PAnUdwwGU4KPXv47n70UrCmu474
         //1WiAfR/GgxisUuyz4yZ4CmUVWIRRgR7FHGCVjQXqkTAZ//Z8R2SmXj0B6EggNT++Ji
         c6PnRM44sT3SFRwPctqAx49kl7XokBfZzgsgfKv8veAiZ5FBXBBq93JzUsN2e8hXQkPf
         4gxAuEVkGmvd7yPGXLf68QSr/7kVfS/uiChtRhGIHU5ziMQ1uwShQkBF9OnQ52IIqcfg
         T5p86v1KKvaIUhGu9wXBMyjgY4jlQdvrfjzlJM7Op9ddy0ajDyLWsENrNkxq3h0V8Awb
         nC8w==
X-Forwarded-Encrypted: i=1; AJvYcCVxzGxY4PKE7Ig+YbWmwzoCk7KNuWqgQUNxPz+3e8jDhOVJlraN7mY4XJdM57WdbEn0KWuokJyMkNiA4ytBo+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPt7hdZEcBj4SuTHfe8z1AlCqa1KyC1Zk+Huo1g3zG9aVEehW
	hX5H8b0Fbjet09MIkCrQDza7mx/9LTR7qjJmc9rUimNE1yfWtgCN3F+r3lFo+5lVhanblGTrbIP
	WdDbyOGKpZoGQRQB8EBXU0B8tDLliTahtA3Vt+Q==
X-Gm-Gg: ASbGnctkhQmI0JDongRQJAoeD4OWOosBYJEs4eFDz8CbyEHR/VMrRXo9UKYiKQPPN1A
	dhy52JRP2SVRoe5/42n9NtjxC0b5kMeP0KvKLO8Lv5Q30R4zeMqU9Obkg7a2SUy37nap2WLAVnj
	AML23Tqu1IOo7VEYi+SzwDy7M=
X-Google-Smtp-Source: AGHT+IGg7MSzyNGZDAm8PN+Rk01IZI0MP6Tn6fdmZrsz3EqNNhB4ics7sazeHz8PLtXzlDpCkQVPcu/JZzZPUSthRRs=
X-Received: by 2002:ac8:5fcc:0:b0:477:d00:b43e with SMTP id
 d75a77b69052e-48e00f625e3mr118569981cf.38.1746446857634; Mon, 05 May 2025
 05:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421231515.work.676-kees@kernel.org>
In-Reply-To: <20250421231515.work.676-kees@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 May 2025 14:07:19 +0200
X-Gm-Features: ATxdqUGNGjWmkQIWUhSlojufuLzXVS_0fzlfJibo3GuJDcGDMsQUmpKRLSDEaqc
Message-ID: <CAJfpegukbiMZzpdP3vLryh9k3o5Uq+mtdjGdhTrtLp2ydQ0a0A@mail.gmail.com>
Subject: Re: [PATCH] ovl: Check for NULL d_inode() in ovl_dentry_upper()
To: Kees Cook <kees@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 01:15, Kees Cook <kees@kernel.org> wrote:
>
> In ovl_path_type() and ovl_is_metacopy_dentry() GCC notices that it is
> possible for OVL_E() to return NULL (which implies that d_inode(dentry)
> may be NULL). This would result in out of bounds reads via container_of(),
> seen with GCC 15's -Warray-bounds -fdiagnostics-details. For example:
>
> In file included from arch/x86/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:339,
>                  from include/linux/export.h:5,
>                  from include/linux/linkage.h:7,
>                  from include/linux/fs.h:5,
>                  from fs/overlayfs/util.c:7:
> In function 'ovl_upperdentry_dereference',
>     inlined from 'ovl_dentry_upper' at ../fs/overlayfs/util.c:305:9,
>     inlined from 'ovl_path_type' at ../fs/overlayfs/util.c:216:6:
> include/asm-generic/rwonce.h:44:26: error: array subscript 0 is outside array bounds of 'struct inode[7486503276667837]' [-Werror=array-bounds=]
>    44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
>       |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
>    50 |         __READ_ONCE(x);                                                 \
>       |         ^~~~~~~~~~~
> fs/overlayfs/ovl_entry.h:195:16: note: in expansion of macro 'READ_ONCE'
>   195 |         return READ_ONCE(oi->__upperdentry);
>       |                ^~~~~~~~~
>   'ovl_path_type': event 1
>   185 |         return inode ? OVL_I(inode)->oe : NULL;
>   'ovl_path_type': event 2
>
> Avoid this by allowing ovl_dentry_upper() to return NULL if d_inode() is
> NULL, as that means the problematic dereferencing can never be reached.
> Note that this fixes the over-eager compiler warning in an effort to
> being able to enable -Warray-bounds globally. There is no known
> behavioral bug here.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Applied, thanks.

Miklos
