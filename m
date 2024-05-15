Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD53A1DC
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744260; cv=none; b=mqf2nizCHUWxqZEj2o8RzXEJDVPK6NjTE4+57Oj737NQ6vIJmYBQu8Tv6GVsKO2zBk2d/GGN6NB5O0DxCc2PFtAZfxH3Kej5zBafsTgkEs8FRXHKAPW777Qv4f4g/uYq2SVLxx+wkkNLzbzjia+h4Zj12t3O0n54YqRjmzZuUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744260; c=relaxed/simple;
	bh=EfdUCHrSrcD/J7rjef0Mhq6ZfzJmqLp0Wf8LNr0IwnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItT1d5NQrvx02LOO4jkg6tChSbo68xKNj8N5Yh3Bm6obq99hAnxiyqrbdSAzUHCfDmre3amVuNiI1zBv5WX4J7BVlphwK1t+LQ1jQnVyItmRsik/ZFzStrKbbA6B1FZjTkQjUysR8dmyiEhHLM7k8ywFxHa8sYnHS7Ku/WWK1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JsiG+J/k; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JsiG+J/k"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so1202723a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715744257; x=1716349057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s05R5WbZKAqPwH8O5MN7TtiDlbeN3dQ+l+K+4TPNREM=;
        b=JsiG+J/kf22f5zkxidK5TpgfcunJFqC5a6wiNNnddL4roi9jihdVBp/+fjuGHJwgki
         taO6TSOS6OOJq1RiyxrV0AcTgICQE51VwzJD6c0i4J/XPgqL1diNh6E1IuCs1qwzyqi/
         wVyO3lkQty9/sPExlHPga8VQPMuh4JTQHRmyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715744257; x=1716349057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s05R5WbZKAqPwH8O5MN7TtiDlbeN3dQ+l+K+4TPNREM=;
        b=pn9TT4gqMkYan3EBSPxDx5lSev1/jsrGJuKowhy8pw6RC4PgaQbIBocuL+0tJTELaI
         bfyEZ+WSQ6dn9GUDHiSdncem951yHRghQi2oC7h3ZKQY5YV5m1mUWzWEGklsV1FOkEBS
         cRdJ2iG3ja6Pw/sYhfXZc3ULs3xZoPwlO1D8aDF9tF6eItac317YB3nhkRTrqvuqqs6j
         7T7wMoOBDmme5STHyfauvSxL9fjPAwO6s5IvOQ+sQkKMvmUs64vNiTvPX6WsBm8DRLe1
         zPscYsPpoKZ/zhKp1RdZ95EwyNm62CdhUw+IGo2Czr/WNCj+Ucg+CJqm7ImP9UTibU16
         562w==
X-Forwarded-Encrypted: i=1; AJvYcCX1MtQUeGZoGyR6V2XKHI38o8hpTy9tdftXsTG86ISB2TjzVo0jhxRbivFrOJHSE73bA2UWGhaHNKEVTpSpU2nHqD+9QDWj3/vPRBo+tec3
X-Gm-Message-State: AOJu0YyOoMWpDF/MwGpMSNQSdfqgSzvn4MW5r+51hPk6CKLNd6UGpI0B
	boQn4Q62PDb3HvJvcjvUWGREo3D+8H1bcbJ7Nagxrw/ehOR3hvXJK9BIaQ5WyVmWUBgd7Swwtno
	QyzD95Q==
X-Google-Smtp-Source: AGHT+IGB2eW3r/mJbVrN/kLhqOwpi0SNK/qQG+m6rh6GxZu10zVxMSnAML8IArpvS4+O7orUe0RMXA==
X-Received: by 2002:a17:906:179b:b0:a59:c7d9:9d37 with SMTP id a640c23a62f3a-a5a2d585cfamr867139566b.29.1715744257105;
        Tue, 14 May 2024 20:37:37 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fdasm793604566b.128.2024.05.14.20.37.36
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 20:37:36 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso929140a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 20:37:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXspHnbx6YuPdUTbdqrxEm/9aQ+AuTc4WOu647CAgDbOqB/L7zexwP7HeQqWHwpUMXCnthG/Nz/1Ws00SXnNBHWS3+4B4FfTrqMBOdtsPUk
X-Received: by 2002:a17:906:3d6:b0:a5a:7ce8:f52c with SMTP id
 a640c23a62f3a-a5a7ce8f6e1mr298659166b.16.1715744236120; Tue, 14 May 2024
 20:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org> <20240515025811.GA1232@1wt.eu>
In-Reply-To: <20240515025811.GA1232@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 20:36:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
Message-ID: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Willy Tarreau <w@1wt.eu>
Cc: Theo de Raadt <deraadt@openbsd.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:13, Willy Tarreau <w@1wt.eu> wrote:
>
> Wouldn't it be more effective to have a non-resettable prctl() allowing
> the application to prefer to be killed upon such an munmap() failure in
> order to stay consistent and more robust against such class of attacks?

This whole argument is based on a castle of sand, and some notion that
this is a problem in the first place.

Guys, if you let untrusted code execute random system calls, the whole
"look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

This whole "problem" is made-up. It's not real. Theo is literally
upset about something that Linux has done forever, and that has never
been an issue.

Stop inventing make-believe problems - there are enough *real* bugs
people can look at that you really don't need to.

                 Linus
