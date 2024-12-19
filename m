Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872981FC7F9
	for <linux-hardening@vger.kernel.org>; Thu, 19 Dec 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602946; cv=none; b=C1lgN4Ez7qQhKK0f9IDPQ756/T1QLWmsTECOdo+sH0OnxT1XeZ3TM9+8kbZwI7tSA0+IQdWtBfAqaYN8AtThiYNtMtl74sNYEyRo0FBZCh5+FBpsBBB5asCWpK7rd7n0rY4zU7tp47Sy0ybh5iFLI7Yshpd1hHiFLDQREn+Lmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602946; c=relaxed/simple;
	bh=2gDH687Y+RbAzf35eofEUfdXtMWrVfNMD6crZe1I8Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qj3uELIQ4aoSMt1wAF7BDIRsAK0rn0WEXJ0YppsIxkh3xjr+sJGJYTZJnJMNFFOW3XBxoPvB2/NGquHfeJoMmVwY3ssYRJepc1ms9veJUALjoUuS5JaeDBpSfFoDqgqb0FYzGaTSkzd3Nkj5ebg8T0i1uCOcCKc6TC5xZ3z9Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVOeWAZe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVOeWAZe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734602942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=;
	b=XVOeWAZeQDZvLOGUIZg8gP+LaHl4CCmLozl2WoL98OmOKp19QoWX1frVh+Qb9Tp8rIwNc8
	lmiIhIjEKHXbZnUArbokYHnhc09kuHObMWr5/zLJIx+AycgDh0k/e56Olze7GYIwh+eDbr
	tMXX+ABD5OK4lxN5uIs4CS/mZKiM3OI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-zXl9U9vyNEu51j-wxGsZlA-1; Thu, 19 Dec 2024 05:09:01 -0500
X-MC-Unique: zXl9U9vyNEu51j-wxGsZlA-1
X-Mimecast-MFC-AGG-ID: zXl9U9vyNEu51j-wxGsZlA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43635895374so8576385e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Dec 2024 02:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734602940; x=1735207740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=;
        b=mDb/pVcutHZTgaYDG8zuDq9DervgwkVX2T9g28S8He7+CJDa+6xAVFheiVdwg7B+zc
         ILKEc1sKuJ8/5nW6KHHckaaRUpmGKPWPJfLZIFN+PzzmctgBsF0JrKahyAzCJ7/dDpnL
         IW0HWu8JmohmDUqksmKfFXl5Q/ZkWgOYNApFOWU0r6GzWxKo5tpNfI7lI/7aHBogpmy6
         genLujmsDMtvJB5Tg1RjGyr2s5Nc5tG9hJcBCnXNb2L2p2omTGc9Emf+2xIadudax4fW
         uZtFp9kTPkvpSXi2BL02rVorOt9KoLei/glCIPXA6BIKVR6o+KuT0AHE9yg5A+fVRHfE
         +Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCXjIQSxD6i6la9m6Piik4MHyRYNnhU+z4YKTQxnTmcWkE0zECkV1Y0yFRg9okVaB0t1mrRdMAJb5QhvcRBt2ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw008P3YpunZl+7iRwa4QLnbwNa5oPeCwLa97su7s+4uzOhl2/m
	wQjQHBo/JNnThxkZ5UGsJo5/Zj01m/PTO5Nm/UZGwFkWaoPsOSs26MSQLuMc7gW+KD1QwTLlBLM
	HiSj97YJmcgvmI4aak1NnVwjSuSe/NRnW7mvVDtQVyFRHbdzchZrjqvUmv1ZK+IMfcA==
X-Gm-Gg: ASbGncvlt9z0uZcCOweTnd4LJ8RgPJQYZlNmh/Z/KDDMex/zuWFAl0ufQOolr3Frk+s
	LgYU6rtR5+m64CoSydIbQyY27qVxAUUTx7hcfHj9gaX53aPxy1zHhKtW5xfKFY/yygNhNro3+kw
	rIlavCoRBnbrl627UD97pZNY6WnJwTwUIAvRIrJVHlGnRZbkrbBSpQGYYwauJtS5DN4KIVoXF0q
	cHYRk9TxbQ7fMJHTZOGEv0ySi7ix4w/baPWaF04wilciT0jBTrAAKcX0/DsF8qVp/LvKSbv0ts9
	2ZjvkcC7WA==
X-Received: by 2002:a05:600c:6b6d:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-4365c77510bmr22352165e9.7.1734602940184;
        Thu, 19 Dec 2024 02:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGirXoXRQE0r5vB0TfkeqRe7MfB/RkGpoRNVbjNqtlwjyADuUYTSVPC9u5W6B0bBw1vsjY5kg==
X-Received: by 2002:a05:600c:6b6d:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-4365c77510bmr22351795e9.7.1734602939835;
        Thu, 19 Dec 2024 02:08:59 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm1189392f8f.71.2024.12.19.02.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:08:59 -0800 (PST)
Message-ID: <badf281c-cccd-41be-9cd7-bf6637c981f0@redhat.com>
Date: Thu, 19 Dec 2024 11:08:57 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: core: Convert inet_addr_is_any() to
 sockaddr_storage
To: Kees Cook <kees@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Simon Horman <horms@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Mike Christie
 <michael.christie@oracle.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Maurizio Lombardi <mlombard@redhat.com>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, netdev@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241217203447.it.588-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241217203447.it.588-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LDZVLJvfKZHqz_yrBT4iFQEK6TazLHzvn-OAJZrMQCg_1734602940
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 21:34, Kees Cook wrote:
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

It looks like the target tree is the networking one. If so, could you
please re-submit including 'net-next' into the subj, so this goes trough
our CI?

Thanks!

Paolo

