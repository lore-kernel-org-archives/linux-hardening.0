Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4523D98B
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325730; cv=none; b=j5xGqn8NpM0jaIXRmPAF4zbYYuK9eDwhFZOzxYixV3R4gBB5sWLTLj+TuBSJ1kRDIfap1VUvja/b6NOC1o3ZoSpuiT6beU32VX8fyu1BVRBcVudcYHvpz56qifkCLXWU8oNRNW8n7e7OU63j6TcM/R7k2OwUFZ8aW8LPz6UFK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325730; c=relaxed/simple;
	bh=0fhuNSDX54Sst9GcjEyXWR9CexJHgJMRh1Qzt6BCRkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ded7/C1wcNYpJyG2k87BC12EJ/caL1YtGN2O4mg3I0T4wyAwEEGdgASQUokp4fEaCEPrId6qSwJ+m/4hsji6TgoBs8gXBOUPfle00UkLYG0XpxDRZSa4LIcxSb1ZauD5Nv8hRk3omPOi/O5CFtAsDMXT1HDAcmGJ9K8IhvCacbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=knvWd5hA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knvWd5hA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1670680a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325727; x=1709930527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yZ/wvCDmHKXxingPVnUfxmRxohhXJOHZFReqLyClyU=;
        b=knvWd5hAWjzX2Et+7XWtXd2GPBDmPpk41CvVahWLBQ/F6xsFtQ0Za+wsCaURMEbZJl
         8bZLFjTDhhRVVeS0TZW5H7J9iUBMOVqsAUnvdkYiH6o7hyu+liv9IWlaMm3I9EzpIHzX
         OJ9Y587s8inOGyf7hZ6Ly5YkrlbKxsGgvp1Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325727; x=1709930527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZ/wvCDmHKXxingPVnUfxmRxohhXJOHZFReqLyClyU=;
        b=cwbg2eVKHLuNgQBo/UqSh6zsb+5OEoeWK3SP2D3bYNWuktoy7pwEjFdDVOBL3BJlBF
         BCUchczmv6HwhzTQsz9vM/Zmfz//jloLMESbs+07FiUQoJxpUug+7VIFDRvCEglYj40R
         3XsDCLL8nyYtxaiilQxn08wAFbgpYyMTZDkxnw+sqNwYWq+zKBeHRyqje6yy9f99ABKH
         UxsU3IReHJEzDp4mkPRiDpIymxIsUSoDoNXLxoDrM7KZN1/VQaFYfFXG4w9+L/8GsN92
         PMQPPYVXsZMyCAlyFTY1itcDBgtYrSAv3XZ88EpS60ZG97+JTYf0lXk37OqREQgqpkIK
         2UZg==
X-Forwarded-Encrypted: i=1; AJvYcCW+EkIrwojpTS06cPV/2SREkKdppGb9M83qxjbZOFZSQjEGMoWE2YT7tYqJgSaptOf41oOWL1lY8kkMhnCZDTWuUtPTvhsr+HOt8SWhlkd2
X-Gm-Message-State: AOJu0Ywlqx2uMa1Q8aHTTqIbIaivSHx62BC/6duAw4q+TFEaL21cGEpO
	MZ8y3KcxZP0coHrWEzrRMdeg4L75MseNl2J0dggW2t8RYJVKyNv91mU20b6gwQ==
X-Google-Smtp-Source: AGHT+IEdOQY/C0bG3YJv9E/3op7+gpy4qW3uyPZdC3FGAVXEJ3godvG4Ky4Z1kSPJMWEesnqRJsQ5Q==
X-Received: by 2002:a17:902:eb88:b0:1dc:43d:962 with SMTP id q8-20020a170902eb8800b001dc043d0962mr2987376plg.42.1709325727627;
        Fri, 01 Mar 2024 12:42:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001db337d53ddsm3943854pln.56.2024.03.01.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:42:07 -0800 (PST)
Date: Fri, 1 Mar 2024 12:42:06 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: axi-spi-engine: remove p from struct
 spi_engine_message_state
Message-ID: <202403011242.C7C42CCCF@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:18PM -0600, David Lechner wrote:
> The program pointer p in struct spi_engine_message_state in the AXI SPI
> Engine controller driver was assigned but never read so it can be
> removed.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
