Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929C3611A
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549193; cv=none; b=QdOJtOhSNgKJEtrrwoR4GkEcyrXP3SltZ8yRZpr0EivmRpCSQGZKmkfEe2X7Q5GQ1hv1c/E/vNfmmNOAcsTZdkXiRPkMFpxIrXlWaDNAUr4gOoYPJ/9u8za/R8e1GuSflo6L1QYXfwwM0+udqiqla73Zb4LfarcYDRWS5tyaJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549193; c=relaxed/simple;
	bh=qa6lwNwuaNmnSvIUXpbojAW7vqsJ6IReplZl0473XF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+wgEfosidINgkO8FVBLmfawE2ub4R5ziwPpiM3u6d6XahKKlJ/HwNHbD6M+JECmmQpXRniXMIxMXZOQiNyseGhgPPFwLLJ6FCidT8P4dszXLFLvNGnB+9cd0utdQh/MkObFqXQXTdLk2chmcVDbhkjgTOAsF8syurYc50y5QeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gcgMYLoc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcgMYLoc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71cb97937so17050615ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549191; x=1708153991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZRBOHYkP72NNNveV+hEVqEGZ7ldBtbUUMBQ0P3CVIk=;
        b=gcgMYLocUStc53ai4JvFtG4qnGOEWc345nVX3KJrSHd0Vrkm3c90x1V0CC2I5qWZZ0
         uPdu93dpjo2CJVPxPpcgN43hJIpe4hgD2dC3+aGfHiQjTcl/4otXb1B8oyeYIPqokp//
         g/EMM1chtpAvfTZe5JhMFxUKuF6zBfDOhuhQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549191; x=1708153991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZRBOHYkP72NNNveV+hEVqEGZ7ldBtbUUMBQ0P3CVIk=;
        b=nhPv5mhWOozNR2AEvokddM5/n59zXhYoyysbcD8J5AKpucvNtK9HeRXU/cay26soDI
         GirX9VT0t1Jv3qLj607SFcw4NDPblYbj2kWAxP3O6g0U8K+QS8glTCPVRt3VvoeK3/iY
         ULQrBm5Ah+eLs561fE9hIo/hIkQ0JAiHIYyKrO7wT0irXSvn9f0yMXyIseY7gLYiXGqd
         UhfGJ9jxKYCbtB3kZzzjOzE3aGcS9GJOdGAUJfviD9rpucP6mSXhaJKitMOksdq+1kCo
         NcXcEafUBjG30U1UBNf6KW8EtY789p8PPe0ItyrSuA22YIVRd68Jz6TK0xcjjZ2lS5+z
         zc9w==
X-Gm-Message-State: AOJu0YzkgT/hj6YHIAeZHqCCDoVN7s/9JNUu/x8wpJU7Dbj0BqCcMgRY
	8H3PbahfHRPK0lw+rVtZ1z6F3Em59dURGrxQhLjMBG771FXDQTm46N6XjP5XBg==
X-Google-Smtp-Source: AGHT+IHfnrueqCTQZn5yBVsCerNu9bFRsxFYoYcwRrkCE11kCBAFTjZ+205YnVm/uIms6cv0AEHi8Q==
X-Received: by 2002:a17:902:ea94:b0:1d9:c37d:7194 with SMTP id x20-20020a170902ea9400b001d9c37d7194mr1528203plb.30.1707549191674;
        Fri, 09 Feb 2024 23:13:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjbPKyAh1Ahj3YvSqb2HTaAM0tr+qznBDgMHZs9QY0DF7fhQwtJlx6RJOp07ohJnXymDKfdvMYZYG8NIbJAcQqBqOYQ5nBlATpBS0D9wIpHEnM8lMGpalxtBzujnB+zE4PnFtE6rMoz2t0mnEWHUHbVZugV27I4P4KLBRnK49llqEuzVfFGjRQJAB6w4KKqiIQV9PCSWJJYkQVhQnbxPC69lqnery7gZnE2LEPPqHJmNmeRFLYAdb9QI2BEbBX18QAjfHlvrGURthc4KZ3hA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001d9469967e8sm2500730plh.122.2024.02.09.23.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:13:11 -0800 (PST)
Date: Fri, 9 Feb 2024 23:13:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/10] scsi: aic94xx: Remove snprintf() from sysfs
 call-backs and replace with sysfs_emit()
Message-ID: <202402092307.FC979BCBA5@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-10-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-10-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:21AM +0000, Lee Jones wrote:
> Since snprintf() has the documented, but still rather strange trait of
> returning the length of the data that *would have been* written to the
> array if space were available, rather than the arguably more useful
> length of data *actually* written, it is usually considered wise to use
> something else instead in order to avoid confusion.
> 
> In the case of sysfs call-backs, new wrappers exist that do just that.

Actually, a treewide replacement for snprintf(dst, PAGE_SIZE, ... to
sysfs_emit might be workable too. Here's the .cocci file I made quickly:

@replace@
expression DST;
@@

- snprintf(DST, PAGE_SIZE,
+ sysfs_emit(DST,
  ...)

This produced almost 1000 changes:
 118 files changed, 964 insertions(+), 958 deletions(-)

Some need some manual examination, like:

arch/powerpc/platforms/ps3/system-bus.c:modalias_show() does:

        return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;

which isn't needed any more.

Regardless,

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
