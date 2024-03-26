Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AC7173B
	for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492838; cv=none; b=mvENIh0B4qHS+qbVJsFanQg966j+yNhhlj3YTjmarD+LJB18TDkd968GaCbuyvjCR8t99CX1CE/+aW58yZLQl5lwKmSE9t8WZ3owt4v8LuT/0SGdasP1+J7K2bdJlvY8Sqihdcu5D6bijrxqK5+Zp00wx/APmbRResmTpbTRp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492838; c=relaxed/simple;
	bh=yx8FqHoYQC1PWSggMb1zsMpypq8jpF4oFVsUHceinSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H361I//4Lt3beBN7w0IbGXaEAA3TysV4miSVFz+t1Jo0x1Bfh8oDa7q8lumO23usJFcXpHRSOhQhVUR0N3xAFNb3JaFiOU43Tif9SStckKiu3Q6foeD71/rWPyOsvCbt2jFO33/m4ERnnlxFGr9lZKOPWJ+Pgu7lyN7YQv290hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JyuJz1sn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyuJz1sn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29df3333d30so4312515a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711492836; x=1712097636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvOJt/m6EX1Fwx/utuRWvS5dkTN8eAFwRhRBD4PxWcU=;
        b=JyuJz1snuaNpYTlA+i/4xYc+mVvynUDy9D5DDc7Eac3f7xnI0TjujQCBHvw5wOPQxO
         ML5NJ6PRBuP3Og8FPFyyMS64OkuI/UqO05nT7P/xcBvUThiP8RHYZq+rBj72JCc5JqjG
         VO8L+mzrTEhdt17mbJhsIHv97WsB3EHzUNcgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492836; x=1712097636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvOJt/m6EX1Fwx/utuRWvS5dkTN8eAFwRhRBD4PxWcU=;
        b=UDu2b68jKD3nTtTpNBe7/8qvbHpxN5cbbk3+uu6sJYlb+/v8aR3AmPuwaK+O3l5YeR
         sV8E9or9XWUHQGjRBa6tG67uZ2eAdPiMb2XqT5yKHdr1B7gwzfpliOpN3XbtHoBwbyp9
         a16Hwc3UmWK8nwOvyfEMUVmI1cRXsp4J3OU2wig1yI2FEJ3nTPf1nckzaxQqO+RQKGvt
         43SZ5653BLNS0rOzUHiCq2EFqApGUOT5x4e+gb/tcm+zOsaH20dVrSyc90zHgi2jMrpf
         jnvBDwtF8+CmlxlTxWeJQnVl+d+DCJBeLWkWGzeDjJ/YSfzox8fLV8zwx2P8Dfgce43y
         LaVA==
X-Forwarded-Encrypted: i=1; AJvYcCWGKan2ov7GwJgDjipTnIgOtxhsK6i6cQfrb9/zp+NRan4YLofOI/+rc6+zXdWNuorHTKAPn3LGOxbvcmNyWPhAOmLPk9+TOhJGMBQwm+mP
X-Gm-Message-State: AOJu0Yxzabx+EIHapQP2rlzB3ilMuVsU7b2ySnRT64k291EvUAvKGW+O
	YHYIMj2KAJQxdMGUEaWKcUW20Y5XvejFZlEHvyMidaqWnw2gHyBL7kQQ2ZPNtg==
X-Google-Smtp-Source: AGHT+IF5G3KrocdACcX+f3m+HzePkIM6XGT4hipE9Q1qTgD2Rdqr0vhVlYeGHO3NcuiylpnYgzVGcQ==
X-Received: by 2002:a17:90a:53e4:b0:2a0:3724:6c70 with SMTP id y91-20020a17090a53e400b002a037246c70mr1191157pjh.39.1711492836017;
        Tue, 26 Mar 2024 15:40:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sg17-20020a17090b521100b002a08ddb5bb3sm130502pjb.12.2024.03.26.15.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:40:35 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:40:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
Message-ID: <202403261540.8F0D7A0@keescook>
References: <20240313185606.work.073-kees@kernel.org>
 <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
 <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa109cff-5326-4f94-aa3b-d83827d5f968@linuxfoundation.org>

On Tue, Mar 26, 2024 at 02:46:02PM -0600, Shuah Khan wrote:
> On 3/14/24 02:54, Muhammad Usama Anjum wrote:
> > On 3/13/24 11:56 PM, Kees Cook wrote:
> > > Children processes were reporting their status, duplicating the
> > > parent's. Remove that, and add some additional details about the test
> > > execution.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kselftest@vger.kernel.org
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > 
> 
> Applied to linux-kselftest fixes for the next rc.

This is already part of the execve tree...

-- 
Kees Cook
