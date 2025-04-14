Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C8E571;
	Mon, 14 Apr 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668674; cv=none; b=rwVSNxFHxohxZkdh4XaGaWQJQXnOg+u24unz0qGStq31mYgQ2OyRGyQvJ6YEjcp/GTwjkYi96QTfd3bMhdJsZ+QKqH+0VsE2FVk6YNaEJT0OuIUwV8BOtW3TWo44OudOZiHgz/5Pck03K0rBX35yREwzAa4eHTV2/kxQMU4koh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668674; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liVHONeZxNysIiRGnMEn13GW6vvYgJo8DwQhyCq4ljQg7P2nBH2N3H3/ONIUe15VRIPMCU8XK4NVqeiIcGYayr5Iq2Fa0QMhf5ZucpxSrGCtSyI8UEaAnMZwlwX+SQR0DQnJF4PUB1zKtGzqSnMp+Py2ace8TzyVHiNfj9s8brY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-399749152b4so2650551f8f.3;
        Mon, 14 Apr 2025 15:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744668671; x=1745273471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Ztq5tZ7frTZbEQqdINrmGBnFXFESB2Sw78MF6fFsngit7qN/EaKGRlDRsBQt/RxibN
         s30SlUiElmUsOWBRdUZwkTtPrwKNkkAAzJKGbefwGxSXSAwggcblnGuxLkogdVgMr4EK
         tI/qdqo2831qKPSI4xunIT4UHyeyMqgFJs8BBtxSGWZxZQUo2KE7X/ilpZ2wUGpCNoyA
         /JGE5Gs1T4j77aBcpB6x/zmYkr4Rb3EVBJdsKJ6fNseT6SunwABJkpajCEbprz9G5Lal
         2yyyrdEU7chdj1qb+3fCY1Isp52Thery1Z1BUfPZMuXKPyQBNJiz9UQ3szNd+fL55N9N
         YOGg==
X-Forwarded-Encrypted: i=1; AJvYcCVcQWuOmdxOUD5F7jQvLujE0/HfXzY4wg3039pcTAyRNNJcDaP5SB0KklzQHGhJFXAGz7ers58/HM7WVz2QchQ=@vger.kernel.org, AJvYcCX2nIrRPAw84kDbhpGShvXu6JZ2P9qHVjnT2EOXWTpkLGYfy7TScHnHo2n2o8wU1n3ANjP8LyidLeyEfxGP@vger.kernel.org
X-Gm-Message-State: AOJu0YxCt5cOZAjAEpmBOHr+k+eQjk0l3a1TReJ3vzlWEpxSOGvdKQp4
	ReT0p9cXCu4w3D77MoTBwqmrI8Ib3hro9SupYyUmlzgjSm5w1z89
X-Gm-Gg: ASbGncus66quMbxY/cwzAP3sj0DubLJs/Nddzao197Wns1Rp/3KOj0UsL2BL67s7Tth
	2vpidbL4v6KKxCoB3L+kHjBc1in7BXweoBRHmW578qvlVQqCea8IDPh1qA0hNFocfnp9/g7njq8
	jdnWKFOjJp3YFqEnSs3L3bd4dwhuDPi04N2d6hIJ750jk0Jb2ovyg+73+iebdCpGPytq1K+v1hW
	JXB3dvSGly4nXLz6GAejRUg/z/qBCrAA5SiCyfYE81aXom3THb61qUihziVPQGWd4QK0ZFF/stT
	UV5G3BQ1CConvcLB2IuEx0zy/7KTqmQJZ1DjBLUoHM+s1rhbLiYSzNhckYMedyif1DTlIL5O
X-Google-Smtp-Source: AGHT+IFCiTY/l8yOfCw5tgPLcaFmiVl0aCRjtPjcf+Zz6hNuEVn0GZMpZiy+vJzvhsh0z12ZqOmlkw==
X-Received: by 2002:a05:6000:184e:b0:39c:cc7:3c5f with SMTP id ffacd0b85a97d-39eaaecdacemr12156572f8f.45.1744668671022;
        Mon, 14 Apr 2025 15:11:11 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640a9sm12253790f8f.10.2025.04.14.15.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 15:11:10 -0700 (PDT)
Message-ID: <a3fa6c12-22d8-44da-82fb-ad4e044cfa25@grimberg.me>
Date: Tue, 15 Apr 2025 01:11:09 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z-axRObjXYjIHGQC@kspp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
