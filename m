Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3218FC84
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298965; cv=none; b=sbmEnksz0Pq+HVldv76/kX9thjUYJ+gnVjpLZBbpAzRd83rHtM+8KbI1J91KO7Yv8JzOOBK1IoTZw/N6sFVd1SYYNka37xJ5gJll2+kvl+pjYM9A9TO5SHAn/xWpqdl01tUxt+f11VB6oG2yWN04k4OXwBwbkc6LOzQf2kFyqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298965; c=relaxed/simple;
	bh=gRIlAEax3BIvtu1w+lVvGOVjLWW29EV7sLFtw39oEmQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkz8aSlMcBxeSnwZXmPmRMV3G6+7WPVNsiic8QC1Lnc06qS0JzfTgZVav4PUl+pOLxHiJ6+do4bvXQthZYIRX4ow1I7l0NsGfatUG+o2Zfxd4mKYTxjXk94UNqBxJo1JMDaBmoJxuiVViCT6jDzMVMeOybu/blZ+c3q3GTYo/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzIwq5UC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzIwq5UC"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e1f673ca8so65469e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733298962; x=1733903762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lsyR9M9GBD5Ii70iml8EFVfR5eQIfLVHJoKX/GbtHx4=;
        b=kzIwq5UCWJ/MWSbFrI3J7A9bERv6MyYThiiqejxy6xdbtY279hvkFUx1E4XOBKaTNo
         opshHa9MZB3qL8ZXtp89Jb0zWHmEUJP4soD9xcjPTJT3P6cnP/AG1GWDMsB4QLFoZ04w
         7C8j+QA/gOgJ8OCwDJWHAwuVCnWV+Hng2HDRWx+TWMz+c6IytKIVdXeimMkOPAsB7uCV
         N94npxhI3QOYmEPko4jp39Rd0oIZvijTapoIMh7sOuBE2uKt5ZQE2w+OT+L783gavQ4S
         O+VL3tAMhaXHag5HN1bumkG96UZupT5IKuor8VGGFboRk0BnidgsAy6XgH6r2YVhW99F
         fYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733298962; x=1733903762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsyR9M9GBD5Ii70iml8EFVfR5eQIfLVHJoKX/GbtHx4=;
        b=YbIW6AcZ5Oy0TJPOHM9ieuJ8vG+MwEKs/eXZy4f7PjbeJkf3e8Ks3gvdniTqXAbnJM
         Ajn6Xw2SM/DcN+tPV2E+MCtEqE6eJn9yyaJot2Mhf9Ewv/24IeHyLH5pol6DbbC5umEU
         g0CHsccwdlqRsGZuvhjRMt92GSAWdnJ0kVXQf6fbZtm+QUknl9A75A5Ozki12vFm+RKU
         q1ghfszfR+jHhELlTqxWVPuQQOVtU1iLHqHRkSN3okJcIb5tAzE8uL5OvSdlnl9a82rl
         yTktBr0kLjRJdWmQoiA2fgW9Zc1D+f7BBHwkfwhOyeNUFRH9OU7pvUQ69S6slovUy2/s
         Y2/g==
X-Forwarded-Encrypted: i=1; AJvYcCUTMeToijCtBz7gNG30HL6FL2vAPkrqrhS8sbuefY7EWBHhK6+gSSZ7TCB/ORnqeg6S5wiX5SCvh0ZBmP3AL4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrpiFowTJpYuxd5JHeRp2nSrerw4UcPrVtvmjJXnaPK6HNEX6A
	CV4yllxqf6N+ICNw2XejRTpnFl3RDRpkmyWybzC7afDSxqp7NKpR2+Rh2w==
X-Gm-Gg: ASbGncsA+1W1fkH0i+0H9SNiX0PcWlOMnBDxWoltSBf2gb0GOdFp4N2pIJpcRSHxl70
	MuyPsOT1wcECr2uAMzZPNf1yANUT5DUNBMxQDy9YoTgau2aNfI1xyZJvFzeLSMreQIZFvmvKTKY
	jfBIsFaFeTqDYbJknARxNaVX3pdpbtx14ThU13wMRESw3qWXPpMT3KiuzNZyaxV0r6KRngMd/nx
	qAEn1VjON5zxCU/IXvYBygYbDgPPZAe2Ct3WpfQMxPjftVvwdU5MOR8ahRA4LX3+iGaBWdHzfU=
X-Google-Smtp-Source: AGHT+IEQJRj4m7thYPzFgmn4s1XCqRNDyQJAWGVXkbmIkaXIDz6C0nXwBgWDHLvhHovO2NqQ05d07Q==
X-Received: by 2002:a05:6512:b9c:b0:53d:ed16:7a43 with SMTP id 2adb3069b0e04-53e1b882fb2mr1360097e87.17.1733298962054;
        Tue, 03 Dec 2024 23:56:02 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1b975d7asm287863e87.82.2024.12.03.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:56:01 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 4 Dec 2024 08:55:58 +0100
To: Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z1ALDmybeJfpIqge@pc636>
References: <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
 <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
 <Z09icnP7QuaLg4Qv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z09icnP7QuaLg4Qv@casper.infradead.org>

On Tue, Dec 03, 2024 at 07:56:34PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:
> 
> I think there are a few other things we can try here.
> 
> First, if the copy is small (and I still don't have an answer to that
> ...), we can skip the vmalloc lookup if the copy doesn't cross a page
> boundary.
> 
> Second, we could try storing this in a maple tree rather than an rbtree.
> That gives us RCU protected lookups rather than under a spinlock.
> 
> It might even be worth going to a rwlock first, in case the problem is
> that there's severe lock contention.
> 
> But I've asked for data on spinlock contention and not received an
> answer on that either, so I don't know what to suggest.
> 
I think, it is not about contention. It is about the extra "attached
load" when a data is heavily copied force and back. On each copy path
you need to do a scan. Maple tree is not that something can help here :)

Indeed, no contention data. Zuoze, please share this if you can.

--
Uladzislau Rezki
