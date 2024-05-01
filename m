Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981021607BC
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590778; cv=none; b=o15wBZQeGBUuO5uANOzWEeFR0hcl+TmY41K5arHvUiVDZ7XsNvy48dw9W5Ijz0v9sXgFLAPkT0A9D9TpS0Wg+ggVuTP4yh5Qge74t1qGuDi64EkZQ4+/ffB+dz3tVLqpgcSRKGnnvdD3hvPp/OP52FItAuLpUHy6JGti0Me9aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590778; c=relaxed/simple;
	bh=EwKEuDLSOMKR1jV1lR+1TeGQ2t/97k23NvQ/j0JLcjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS8Bd1MjquXh3cqhEll404Mifc/4+5K8P31QEEYu2kW1OVIn6Q6rY9+O3KfkN/QrsYBbBsaWaPq1wrL+Id/WK1r79+8Q/GIKJzJx17Kod+muXV6yTUrF5jRnVdusSqjxLkH2YVSpWl3G46vyYwpWClxcYJs52KXnO4Gwgo6qbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hq7yxo+N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hq7yxo+N"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eab16c8d83so57948375ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714590776; x=1715195576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftc3aqw2Fz5Res4OfCV1JsnJI6jUFRSYvKQ/iKjV0XQ=;
        b=Hq7yxo+NaW7Cm+zBacnYar2Szf0QA8VfyMW+IOmQUfLN45/uoanAj2i8NwL8Au4UEa
         utNBUAvm5B6gN+k/8J00l9BLYDh9Xl3vcNIJaTEfpN1HymUNSc5K0ImUjsYXpm3sA7HP
         ed11wZ2ShTkIJEzCAH3pDCA+75X6iuyCS5S7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590776; x=1715195576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftc3aqw2Fz5Res4OfCV1JsnJI6jUFRSYvKQ/iKjV0XQ=;
        b=XkBkMurTt6D5PKPgCCDxG+z7ZdQDC7InRdkiysjgC0UaXB0MIjfcdQ5tnmqa7/AS6B
         z0EztDJcLQdKNwLAHcSnoV9D76alH7LbNEke5uEyGi0l2os+YMeyij1smEkoOpVurfwY
         k3Zc4DX2qF0JtsaUD2/L2xgdWAl8TUzqBuD15pk0vhr2xxI+xebCPuN84cnHOovnBzr3
         jOaS+ROQsmeMl630lK3H7rMwzsrUAFBA2d96yq1KiGPsmO89MHc/eSICGnWYDqHk54rc
         WguhXVNo3DMNdI8EdgyxP+oIEtgjp2aNkhl37UiA6DY7kqFjANmsgxWrkL3AwdZ7QSlD
         DTtg==
X-Forwarded-Encrypted: i=1; AJvYcCWOsxA6qPk46aheNPJ6yPFeqUR4pH5/jXHtb6VK/i8ve5TDO9y2f2Stz7kjakGtRKLv/evEJc+HY6Jogwukg0nrVY+cFE00P92CXgF3vgoL
X-Gm-Message-State: AOJu0YxWqk6wIMePqmcsXti4KDYVUZDftX2IbTXbK0m8lkCIkntPIiGG
	94NDeQK62ahXFA6jaTJjqwiEn0s8i5CAn5usk9pfIAEYsVWO4r8UbPc/2KCq+A==
X-Google-Smtp-Source: AGHT+IEiiv4rwNYFZ12Yp4KZFEplJPkRZSFlARmbW5OqhUN1DFUPbsYrXnx1y8Mx4Z+i9AF52A722A==
X-Received: by 2002:a17:902:f550:b0:1ec:659c:9604 with SMTP id h16-20020a170902f55000b001ec659c9604mr3860603plf.50.1714590775996;
        Wed, 01 May 2024 12:12:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001eab473021fsm10057496plg.168.2024.05.01.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:12:54 -0700 (PDT)
Date: Wed, 1 May 2024 12:12:54 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use struct_size() in
 hci_le_big_create_sync()
Message-ID: <202405011212.4F3C0C1D@keescook>
References: <ZjKFWg0f9uU5jxaI@neat>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKFWg0f9uU5jxaI@neat>

On Wed, May 01, 2024 at 12:09:30PM -0600, Gustavo A. R. Silva wrote:
> Use struct_size() instead of the open-coded version. Similarly to
> this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZiwwPmCvU25YzWek@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
