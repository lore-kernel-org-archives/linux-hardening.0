Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47003812DB
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318948; cv=none; b=pZlh++I7QXrfT4erinzRwXZlmq0faSfNCeqnJhxjKsemZ6gMEJiQSVhTtO2i2coZqMk2GBhlQS7sIA1hjLyTjNJMkviQOPG7KvvWX04mUcg6KgWs4t9iJcqqREMdXe5yLqwaOUI2HEW90DnOUjzARt55y7MWUj4TOsJT5i3PZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318948; c=relaxed/simple;
	bh=KqBA8VViuw8N3Es4Y4QnkWH50mYc0aPmfReMZO/px7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:
	 In-Reply-To:Content-Type; b=FvNMkZomroOBslRuUT7zJggXZ7l1ogzI1syOb8HSFE+unNv78KtLnVGsfn0yB8ZSNCXFuGFvQToNt3ULsAB0DQPN1oB3QAV7WR8DVUNqeLs0zZDf/hNRFT8U8B9/fPc3lOybzO71XGSZMA9p2IGRF81wKHDghGQUrNQTzgkEXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jZx5P2j0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jZx5P2j0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Cc:From:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=KqBA8VViuw8N3Es4Y4QnkWH50mYc0aPmfReMZO/px7E=; b=jZx5P2j0oRHFX+5xL6Vys7IFdu
	kftJ4ksFXlShoJdtyS8BBsgdAEn9+mblod5tYTI45/lQgbgrzu4hU9ofwfw17dzIxx02Th9nI5Q3j
	ugvn0Z1pSsmCBgwPgZH+83yWTmCDmeuFWmay8BY7UyA8o97tgo5imcSssORr/1FIZtk9yTBildD4h
	qkTC8xvLSChf/lEvXdVcPyONh7Lno+mHOUHurTe8XJzMUEmCCSJspBHcKQCj0EznlF43Bm86V8Dfl
	zcMdFTtv5bt+C92DFuW6+xkhBqSkWxnCfux/5EKelB46Y6s+4AWhAnAgoeT9wNd75BQHB+9/LIsCb
	RZYSmGgw==;
Received: from [187.90.178.110] (helo=[192.168.15.93])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xEBsy-00DcMi-Hb; Tue, 06 Oct 2026 22:35:40 +0200
Message-ID: <ded6fce8-f2b7-afac-6742-0a6391b556e5@igalia.com>
Date: Tue, 6 Oct 2026 17:35:37 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Small improvements on pstore user experience
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <kees@kernel.org>, tony.luck@intel.com,
 linux-hardening@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20260922212532.98571-1-gpiccoli@igalia.com>
 <202609230016.101B0479BF@keescook>
 <dd3810e4-7b98-ca4e-f20d-0a7e863d7983@igalia.com>
Content-Language: en-US
In-Reply-To: <dd3810e4-7b98-ca4e-f20d-0a7e863d7983@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

V2 here:
https://lore.kernel.org/r/20261006203412.175427-1-gpiccoli@igalia.com/

Thanks,


Guilherme
