Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605AD1A29F
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548341; cv=none; b=Q3nso9ewTkZdAJT6tqIo/jDnxwtcU0ETPdQts6rxbPvMFW85fc4GHnYkEoEbtmokK6eMenbfBSgc3dy0NDnnsWzkoUhPqWVX1p+Is8kMH71c3G+RbPUcm2tOzwcy7vD0vu290ij8CWu5ZzKyPyUvtnV5gvcQ1ehZgn6W6LJsb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548341; c=relaxed/simple;
	bh=Y5SWwtzlY7akdjVtlZdQaOz5bozkiblf4oOcM6PlM54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/YHLHgHuSRIDoB9DuU7OAhrPDLEAv1MF69q3s2GBNeumQrfqs5R/OnD34pPI0MFfad0aaZ0A3vVb1E/2Dm/w+/eU9LjTt7AytSRPZrmajSGiYIZOkPjJSYGCI0G8nCifJeLKpHimRABA/AIFe5i5kPhiH1l+aE9nEqOf8dXW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mPEt6gy7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPEt6gy7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d51ba18e1bso16348765ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548340; x=1708153140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGphOPJmB8lCgsiAECv7yh5QjCdlMu1K1EXUdSxvbSo=;
        b=mPEt6gy7rLDFRHrpF/wYVQQH13RKsZYdZZ4x1B5yNhNKImoJ1t04UqvFyNTg1XKgLG
         itHJNetjU6mgOTsnODS53xY+KCo14UagbwCxGMPaSs4W4K760SvwjPEgDmR6pTVt4+2B
         TdS+mIhDVM9wyIr5eYO1IGIq0r1275/Z0yKVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548340; x=1708153140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGphOPJmB8lCgsiAECv7yh5QjCdlMu1K1EXUdSxvbSo=;
        b=A4fhoGj7pIFT/r8b5FxId4Swjz7OO/ISSRT3k3eV9JF0241lg4la9Hyf+r4b3/knEz
         w5wVRH90LeIyxhe3A/zEEA2D0dFWCLgFq76PotBYhT1maWL3lChuGDaA5WwmuFkmMRzi
         e/KtTQ/Y+C/0IMGd01TC7Jp0nykByD+5Zi4ieze15l6DK38UG1ioIzPuK0uoyYnEea1T
         ApRxkEXuK4qnUugRrcCSIp1qNP/1imIZn7Nq0e9GrNMI31iaw5gqGU17S8YYw7Vlqvxo
         duFxhg2eUMBkVZuHk1kizgV4yyyyMnABnol/Pm0yfI2XIuyGGGnTrfddS0wovLo1tUQs
         Z/7A==
X-Forwarded-Encrypted: i=1; AJvYcCXN6cbZy/5xrpzn1oh1CJePNS48O0BGRgfqcCbLV1a+aNUGSWj2aJdwo75Lsc2xIj45ZTfJPLXa+DKBuo02o9NfByqE2T+DsWcCfFfjHahh
X-Gm-Message-State: AOJu0YylY8lY7qxpITpc85iDc6zhGYkTAA3nvhr6TAzs1ZXF+0+So6ie
	wne4wXg8PgTKw26WxKmh0Q8kEUoJqN9WVpMLTX7kPD4bZWgjp3vjCQbmsacjug==
X-Google-Smtp-Source: AGHT+IHTnF3fGuzslfqsDKip3bFExZj3gSNORqyeS1D8vTDmuOVDSx+jeux26obr0yz2kGNSAwz50A==
X-Received: by 2002:a17:903:40cf:b0:1d9:6c3:e24f with SMTP id t15-20020a17090340cf00b001d906c3e24fmr1719392pld.38.1707548339797;
        Fri, 09 Feb 2024 22:58:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJxTovjWaiv9g0IvLBZWYtRlBzRueKPP4/yrb+Xzr6kaMgQKEcgbUHUQGkTMST1B8UcIKVDo8HYkXhW93TEzKRAW/tBwGmIDMBKV6iAp1MWi/nwB7jrZokLH7Lw3cFTuud2KbwKjlvFfNS2JaLa/z6PbM0GaO3VfUer6+XzKyWYtzkn2pqtDWz4KNNxxGzlWSjNs6tUwRNSB4Llg27wr6lZYd1q6nyD46giA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902f28c00b001da15580ca8sm1678034plc.52.2024.02.09.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:58:59 -0800 (PST)
Date: Fri, 9 Feb 2024 22:58:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 07/10] scsi: aic7xxx: aicasm: Trivial: Remove trailing
 whitespace
Message-ID: <202402092258.5E568EA69@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-8-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-8-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:19AM +0000, Lee Jones wrote:
> Removing out of need rather than want.  I wish to make proper changes to
> this file, but my editor is insistent on removing whitespace on save.
> Rather than go down the rabbit hole of debugging my editor right now,
> I'd rather stay productive.  So, out it comes!
> 
> EDIT: Found it.  Looks like 5a602de99797b ("Add .editorconfig file for
> basic formatting") now forces editors to trim whitespace.

If there is a v2, you can "squash" this. :)

> 
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
