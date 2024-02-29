Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044659150
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165931; cv=none; b=fzwZmsscwnHV3ePrwdAcOjFrrzOs3vnE7qNRw7mZFz6bIP2PdVpLLwMKLjn3SYKgVbn+ICMZNYHA1NPKqtTPnwT9eDpvHHz2o+awienf3azP4UzPfpzTj/1GG1v4aPlj1cobzeH6ZQIH8IrRUy4USpPj7CgK1rAjqn7biKcf6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165931; c=relaxed/simple;
	bh=9DJj6YTz0ZZOl6MAUN9AsplTyADMYRPheFd4FjREcq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPAoZtlI3LjXq92iTRVPZOw64/wZYtDq/ep0HfBT8CjZ1dGHRk/rlnsNDZ69sTCOyNUAN44E0rEdxjwlXMJMSQ71CZbdtqcntJEDXT8FqwZOE4VKHklGKWEIIblwBTxFXvPleTFxAIsDagTxhdKDIfayw4k5HlgCj7rYqjjMokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zd6FsrbG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zd6FsrbG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b519e438so275359a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709165929; x=1709770729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5uqn8jk7ThAKtuWvpjc6qdSbK1EvuBbH6icwTpGIW4=;
        b=Zd6FsrbGvnNHW8S/xTkaP8iOt0/OYTPNpeWEampDlCmOtdciZpBKQacdXgA3W8WqKd
         je2ed3pek8hzLO8jLXSAiCfElrc/dD2tOLHFMyF0P5JuV1g+AZaU0I40tkMAVPEhCjEU
         kbIf/NuBfZz5rKsXoMemtF89f69aO0mt0e9/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165929; x=1709770729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5uqn8jk7ThAKtuWvpjc6qdSbK1EvuBbH6icwTpGIW4=;
        b=FA8lqv/Od7Q4R0prZylHdeDXWLz0vgrr7W5zQsapUrD8DXS/xlvQDuT+m+HN2BQ/og
         j9hIK8ejIIVCHXJmmtm0gRN7c3x3NqswEz8Iy67qWoBteuxu/1qbu1hk6kCLjvz7VHHM
         0fly1uKlJCWUAAotVMORMQGotP9++/hB4jiLfkxu0o+SW8ivwfpHeu6X6+s+y9R4PaxS
         3bhqbvomphFUAi/Ftxxa1V9m2zL6mkgPDizTdUlyDVJW/ZvG6fabFi4V7+rkOmCsrVHA
         UFU0BvjyNSy9CMg4iA70C5qvegNPv6GVT6QkwcEKIS43NvX95bwedJNCFixGgyBEUzp/
         d4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUuD4qdkjjCoj1tOv96euMEEVXTR8K5xWJXsUeu1Bc4tlupG/TAGwHMRuB5zZQ+X5wJ8lgAKnx3hKCR/ugOt50lcyILZbBEea1VDfW9Q06e
X-Gm-Message-State: AOJu0Yz0aGv+lt9aMbXh4qaGRrBW3p+ts31SqLyXXrZpnURGWIA0DRU5
	Xrkq9+VuhKIDH8Y0cFvT9rg0Hai+e0TMjMwSLUixT5FW0vHBdn3jiSUU3jqweQ==
X-Google-Smtp-Source: AGHT+IG9LGv7xga1c26psaW5lSQ/a3FgyK1kDrzHgkNdLgVdVr5RsO1xWGsalLcOFQ/g2GqHBPATsg==
X-Received: by 2002:a17:90b:3905:b0:299:6848:28c1 with SMTP id ob5-20020a17090b390500b00299684828c1mr834549pjb.26.1709165928724;
        Wed, 28 Feb 2024 16:18:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id su7-20020a17090b534700b002973162eca1sm2292760pjb.17.2024.02.28.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:18:48 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH v2 0/7] scsi: replace deprecated strncpy
Message-ID: <202402281617.807B1B7@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:00PM +0000, Justin Stitt wrote:
> This series contains multiple replacements of strncpy throughout the
> scsi subsystem.
> 
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. The details of each replacement will be in their respective
> patch.
> 
> ---
> Changes in v2:
> - for (1/7): change strscpy to simple const char* assignments
> - Link to v1: https://lore.kernel.org/r/20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com

I think you lost my tags for the later patches. I re-reviewed a few and
then remembered I'd already reviewed these and they were unchanged. :)

Please run:

b4 trailers -u 20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com

:)

-Kees

-- 
Kees Cook
