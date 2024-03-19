Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8B25605
	for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867392; cv=none; b=P31SnrVqyMAUC15UGsumBSaAHa/bHDZ7K764+JGFX9JaINZhZdepYEhX/v5Jf0TLj0u2cVMUDg8VNUhTQMUMWTzLVCuT9Xyz7vXYxJZ8+J4sfsNOugrZHCwbyJ/IuRSbbJ1rCb2TvtR1p1xrdMSrbjbJpNCL9EzYQG4tntNd780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867392; c=relaxed/simple;
	bh=xjgzHX9IZesh/m9mX3LwRDZEWPaQf//ud0zb58ExHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBb8QZ9e9hG3ma0+wMNhQVeX8Mkmv6Sb4wJfA0u2q84fVt5rnuqXxj5GGIulV8QamsY9+XRiXcbmkB52GIwMuJ/CUkD7w9DwKDoyBKKnuYWra+AvOMRN5231+PK/42vq1+uIna5wyZ9T03FMoyrmMqmDL5VMLkUU8DafTn5DVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GdiPitYE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GdiPitYE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def89f0cfdso586645ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710867390; x=1711472190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuNfW02G+/boJdMGNpGppLuETi2AT/FTA/TQaVA8xgU=;
        b=GdiPitYE6QEh0arRBKslX2pd+8Naw4qNnm2dLaG2i9ZWUkrECenDxMpuDRKTcfCjAB
         VD2Vzs2WKLtE8gW8EJUYMQvpPWVmNNMDgiHQNSIPSj6AgJjp1E3gvYKeBIrMtmaXX9a4
         MuMI89g55ZTiiY2VxygXz6bcGtN6NPDJxYtt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867390; x=1711472190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuNfW02G+/boJdMGNpGppLuETi2AT/FTA/TQaVA8xgU=;
        b=oUTuhvovITturzDFyHWpJPytt6PNOJzPu7eDbaTMQl0Fgbsrb2MoIt22os3uRlTPQK
         sexLU6wnobPkorJd3r3ZaVL4fHCCNt4tl/37LvhA09KWrAX0Gr0hObxVz65ZOdnXQSK8
         GPOkHaIOuWnDqNnU38bLCUIJCd4MbyRSSqZFbtIakGppDaw0DvjUN1cbUtEnAgA1yacZ
         VssI1sASMbwMR18s8PbD++WgcQ1P9YfbXM5tpDF5laTE+5vEXcLXEjRkT7o31ZwR/egM
         8Fz9w2t9aFBXCnQWJp/mYcl8iwsAWgChlB6dk+zLUvDidXc3pbRS3rqe7CsgvHt5FUqY
         b+OA==
X-Forwarded-Encrypted: i=1; AJvYcCVaIghRUmWUPQdLeXUdVAWGd9XfB+rBct/9lBJqzOJafOISqa5IUdyM2OxMB+km7DQeIbkWKffDDw93s9ZleQHbuozt5WO9NQMMDP1X0JFN
X-Gm-Message-State: AOJu0Yw/40kL7Bmy4of58mxgs61wPPlVbgcsBM7CghrY0t6roORbB0NX
	gOVaXp5lJd+R6+YD86XLJQTo7Bmx23U9Hxk8G89xTeIlJ4AcTCQxsLVSICGqgA==
X-Google-Smtp-Source: AGHT+IFkeoK263knhmrpLNnBINDlmy10rclHAlIAD41tF+qJaj4Clmgqm/zNALlw6SqC/+XtoKd3Lw==
X-Received: by 2002:a17:902:a388:b0:1de:fab2:98eb with SMTP id x8-20020a170902a38800b001defab298ebmr51491pla.5.1710867390467;
        Tue, 19 Mar 2024 09:56:30 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001defa2d8e22sm8424413plk.233.2024.03.19.09.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:29 -0700 (PDT)
Date: Tue, 19 Mar 2024 09:56:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	gregkh@linuxfoundation.org, tony.luck@intel.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <202403190955.25E5E03E6@keescook>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
 <202403181644.690285D3@keescook>
 <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>

On Tue, Mar 19, 2024 at 09:16:40AM +0100, Borislav Petkov wrote:
> On Mon, Mar 18, 2024 at 04:45:45PM -0700, Kees Cook wrote:
> > The commit it refs to landed via -hardening,
> 
> Yap, saw that. It should've gone through tip too as it is clearly a tip
> tree patch.
> 
> > responsibility of landing this fix too. But it's fine to go via -tip
> > if you prefer?
> 
> Yes, please. Just send a Reviewed-by and it'll get picked up.

Okay, thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Btw, while looking at that second patch, why does it have *three* Fixes:
> tags? I think it wants to fix only your
> 
> aaa8736370db ("x86, relocs: Ignore relocations in .notes section")

As I understand it, the first first was incomplete.

-- 
Kees Cook
