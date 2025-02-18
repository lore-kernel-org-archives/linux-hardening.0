Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178DB22DF8D
	for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869116; cv=none; b=nvl5+2zRJQLd9H9CokQZreUJtvXKZH50P4W6ssQv9ckBMtbVvqjvqNt0CkTuSob7y0NMzZbFwk2KTfMU5pxPqLDVfRc4ofsB0M98Zte3NF0YfMpkb218/+TOr4EiQkW8Br3G0qALJa1tgyirDjREnd0SzGzHcf8OHyYHUf/TLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869116; c=relaxed/simple;
	bh=Gf1I336jgiBsKtK6Xe3UxKCB8/iP1W2mCBQ9k2mDag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpFDuFsTfIh+twOKyT41m0liF6H5xwjUb9j3s24XziZ7WY5MpuBrwRVGUebp1C/U5nh6bP95zi+SYmKALsiie49CGxT0vRpD73vPg4w8qMM5KLkZwQFm9mklNKrDtjR1WVHKnKvpr3Vdz76bZ8xdfGJhR+pkjKYlrifeSrg7/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZZ2ki4+Z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZ2ki4+Z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c8f38febso93805125ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Feb 2025 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739869114; x=1740473914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qqCVPwdqyK2Ili+2+zXGFMWFYgYIwIsQtKu/VjLpL8=;
        b=ZZ2ki4+ZluLnIrI8lGhVWfzy2c4QRjXxsq6o4smOG6YXKiwMtI4769jQ/eUySaXbip
         u7PCqorrd/xBE3GkM4sbwyf/lzw0SffuZagKspjRcxPs/SgaQNjcwkaaCYe5fMx+KxWm
         g4nYs3zf+ZZAuYPpHP5gqF9BWTCn6URDFtb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869114; x=1740473914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qqCVPwdqyK2Ili+2+zXGFMWFYgYIwIsQtKu/VjLpL8=;
        b=HVyTwLS8vugzQHejsgrAg8pte+bES9uw3I37Cd1yWRrstk9xLk4DniwDf5nEDjZUkc
         5Pom4HU4Uc+6P4hOE2WEfASomEVZOJZL/EKUET6vh88J9QqkkeLkBsvTSpXJbPm8JlPx
         1d4FrnHEM9kiLcqiseyWgXPCMPnIoQtOtHH2xiAVAEC9iom9jh0HMsxse45c4l9hzMr7
         8Iqyr8JD/Rw+3h9norod+qHWtSBu76ZR9hTi4OLXYW3WwW08za3Oci3R+ZRXVZywK7g6
         QB9kd4L78s6n5IxNg8gM0mF1aJL+gnGn8NRpKVj357Y8cqmZj0GDUsKDIVCtierdN4WX
         +09g==
X-Forwarded-Encrypted: i=1; AJvYcCVRYYai2n4Hy6H/v+FILzFzGrktdhtzLpIKCXzggTsey4YNVJvQcMws7osWeG1FZKhiT2iPSTpU5ZUzWQ+CqDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PIMES2Hqc/knDrz3VEwbsJr01YnD7aEvyksFnofcthgnXarr
	Z6PgJpo7e8ESVvy7AGwCjNKOuC/tDYyoDNloZ9sk0UwewuKejBsExxujVXQP6j9i1ZnnQdwQv5Y
	=
X-Gm-Gg: ASbGncuqtr4sSthNln01pLJHJx9LfwCFusN+CZw7YaWvM5zXUCAbluimHUeUxmJLTlC
	zoyeaLooGT1hqBTC3WVYWaxsHPDr1uVGuhbOIkdhyxsfyBP8USqvp4CFlOow54wfIg8gjILrHVf
	+CzuOAOknfGEgwZmyHBhjsHJFYjQnac+7UP6bTN1VqrmhQG2z1EVGu/Q9wMn1wELZrmLZN/hp16
	idl+gNJ+XujV1MCHe4/K9W2MWIFu5YHjHS/i84Ct+2S1uLLdOSBaRJQlVyc8KKCHRbdl3kkl3J9
	Iz3k2p5pggB/9cQ1al4=
X-Google-Smtp-Source: AGHT+IEEOJtMg2r+ExCu5k7nAqe+yfuyqpapvJqV+nJnjxWfgOfZJYnuiAmofVtL8kqiPugF9s2+qg==
X-Received: by 2002:a05:6a21:790b:b0:1ee:a914:1d64 with SMTP id adf61e73a8af0-1eea9142045mr12447625637.28.1739869114293;
        Tue, 18 Feb 2025 00:58:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e8b0:5a6a:30d2:a33f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm828296a12.51.2025.02.18.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:58:33 -0800 (PST)
Date: Tue, 18 Feb 2025 17:58:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org, johannes@sipsolutions.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, pmladek@suse.com, rostedt@goodmis.org, 
	john.ogness@linutronix.de, senozhatsky@chromium.org, quic_mojha@quicinc.com, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
Subject: Re: [RFC][PATCH 07/10] printk: export symbols for buffer address and
 length functions
Message-ID: <20250218-175733-neomutt-senozhatsky@chromium.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
 <20250217101706.2104498-8-eugen.hristev@linaro.org>
 <Z7RELnyWRLietj9b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RELnyWRLietj9b@infradead.org>

On (25/02/18 00:26), Christoph Hellwig wrote:
> On Mon, Feb 17, 2025 at 12:17:03PM +0200, Eugen Hristev wrote:
> > log_buf_addr_get() and log_buf_len_get() can be reused in another module,
> > export the symbols.
> 
> Err, no way.

Yeah I think we've been there before [1]

[1] https://lore.kernel.org/all/20230905081902.321778-1-hch@lst.de/
