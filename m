Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17B14533D
	for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887222; cv=none; b=OgPWc4K6hgpMGhAnaFkzOw07MsszGdlbIUkFTic4y1931sTgzthKPKCgzMS9anPI75b6wkC/bFGUX5SXR2EygI/TZsRuciXSSg4sP5LVPppsoZL+L4JuyOTVLJ3uipj1DtBYCBapAr726EMeyxYxa0RFmFNt9RfIrGv9LSaYQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887222; c=relaxed/simple;
	bh=cecDsCS1JgN0/FP61uJPZQH9+fhYkN4AuLokJpvFnD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhIt/Ssc8I3EmXnvGeNcfv8BTHtbpFkuELSbQrrnUg1WniRnahEHPVkDvHBsM6h4hLY9MmL3UVDA9a+QYz+TzqwPxWN1+9mf/m+2+EHg5Merv639HRYilEOtSTXcMOn60f30bELnnffxy/lLWJB4l4iy8gEcmfCGcqJDv8EBueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T78WJJpK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T78WJJpK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f0537e39b3so54613775ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 16 May 2024 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715887221; x=1716492021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHSzNaB00onTGCVgdV5WXuaIuSKL0HrxfhXFYoCqc/I=;
        b=T78WJJpKNSF/EGdllf7oVLmKlN7E4izQ/kbdwOcfo7FmVi5BOy4Vx1SsHCmTA+xJIj
         2UMS2gA3zxjQG+aKhdv+XuUh++otUeo5J5tQ7d9PfNfNcCYNFsYxV9dPvKUX2iCccQCE
         qN61uWNo19H7xjeX0EOWIoCwsPKFU6MDX+duA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715887221; x=1716492021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHSzNaB00onTGCVgdV5WXuaIuSKL0HrxfhXFYoCqc/I=;
        b=Z4HbQES9uAXQgY3dOJ7MWbLQWrjtFSrUAIM7BlsGjhq9xnMfBid9p3Vxo5bzu1i/+l
         PhziswQw/CJLN3F8xJvsFbBbGbVuUBN1s7GuHTMJNyGMQdxEGT5DqPzE8OPcNNSYryok
         k5Lz1W37RMvuhDGXZeAZr2X2ZsoyM/mw99dnZrzwbgG+mu2+SiGxgDad1FwZ4qBGrxtT
         Fx1qtjI/JiJWW27Q8f4KB6ygIpVpWyPJAQPi3nhcMRwGRo+dTQkoAb4oV4xVzOXA9h3o
         CUMwj0GAnbFDdM+Pwr9KtS0N5SU6Rw5UDUljw26gNTKaKWuNAi+6QFS/dcYfkovS9cxi
         9hTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGs3RXSvO3Kn5FOJbz3MjJk4oE075ZfY4a6MWcm80rTKqPACEMICknCErlElw6N+IAW5vG65B0Ua7ZJGVHTvzWp0PyzDZSZEU5RDVBuW66
X-Gm-Message-State: AOJu0Yw9l8+PuZ7gybg8dHWXbcuKaBhR3GNs3fzEZLXNkIlWH5qPbXei
	7palVtbH/Lwk/rHr3+0Fz/PX5XYHyVeXmRSFfGgY5AFNwlbOV+XBFzIPyMprmg==
X-Google-Smtp-Source: AGHT+IEl9yDXsJVCh8Q+woUCQGWBCD92F59UBfoXPHHzCsxbLL7z7A6t1AFJMPRzTRnJ3zY+pojz7Q==
X-Received: by 2002:a17:903:1c9:b0:1e3:e081:d29b with SMTP id d9443c01a7336-1ef4404fc55mr246620125ad.45.1715887220716;
        Thu, 16 May 2024 12:20:20 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036135sm141967705ad.205.2024.05.16.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:20:20 -0700 (PDT)
Date: Thu, 16 May 2024 12:20:19 -0700
From: Kees Cook <keescook@chromium.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Stieger, Andreas" <astieger@amazon.de>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Subject: Re: Extending Linux' Coverity model and also cover aarch64
Message-ID: <202405161217.4984DE258@keescook>
References: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>

On Thu, May 16, 2024 at 03:28:16PM +0000, Manthey, Norbert wrote:
> we published an extension for the Coverity model that is used by the
> CoverityScan setup for the Linux kernel [1]. We have been using this
> extension to analyze the 6.1 kernel branch, and reported some fixes to
> the upstream code base that are based on this model [2]. Feel free to
> merge the pull request, and update the model in the CoverityScan setup.
> We do not have access to that project to perform these updates
> ourselves.

Thanks for this! I'll get it loaded into the Linux-Next scanner.

> To increase the analysis coverage to aarch64, we analyzed a x86 and a
> aarch64 configuration. The increased coverage is achieved by using re-
> configuration and cross-compilation during the analysis build. If you
> are interested in this setup we can share the Dockerfile and script we
> used for this process.

We've only got access to the free Coverity scanner, but it would be nice
to see if there was anything specific to arm64.

> To prevent regressions in backports to LTS kernels, we wondered whether
> the community is interested in setting up CoverityScan projects for
> older kernel releases. Would such an extension be useful to show new
> defects in addition to the current release testing?

The only one we (lightly) manage right now is the linux-next scanner. If
other folks want to host scanners for -stable kernels, that would be
interesting, yes.

-Kees

-- 
Kees Cook
