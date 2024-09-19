Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB41917E3;
	Thu, 19 Sep 2024 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729687; cv=none; b=f1QO7z3UTO5SVKYJERo+evbeV5+Wkp9iJpYElZJhuxXhmZx/T3DZGkC2ks4b+v7CEO91K+1twnZdedyZ3/Vu1V9jk47U2zMrof1t0b093HApRTNB6rysHbrcNqDPdP7QUV9Pt1bQ3tIHqeNlGp0snR2mwfYg3K3nGvkThy6lVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729687; c=relaxed/simple;
	bh=AsoeLMkPtuAQtZwZldBkjJAV1+R8rg7d1q3UbPWQK8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=gIsjlzGpG44lHsk225V2agXQBRjRQqgxWB8OaDL16M4Fd4IZZl3XiBpiqjLHP5HIx0XzJStBLvSIPQRgyb0/YrBumxvzyRk2PHrpJbMyLMUk5ST31Km+CPGKq/5hfUjQr5MG246mkP7MiauioGTd1cN+RbyZij7WTOw+RiwRBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sE41oxpk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sE41oxpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726729678; x=1727334478; i=markus.elfring@web.de;
	bh=cGs2WqBpNcN5WRBfx28twMu1pLAft+cuvXGRLFsvlyA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sE41oxpk+nMJ/NwUVbtFrmhxuD5ZugCYz8owI2zxraUc6xQcE++VNhTFJhi7dPz9
	 GH06SRdT00W5t/a6kprmfBh1L/U3BblaTRAaoiXIvYGScN+m/ujyMwf82dWgiFRCa
	 rQkmR9b8mrxgYA4UfDuKIs7Me08CXACNF+PcmyvaoOkNtI3+k3/TvXt8W+Ub05Uvr
	 kCIF42gdhDC3i+AKcmJoPBsvYgNnTFu33yDmWZk/61GvmW5LVtdTT8JO9os/2XWBP
	 9VmXlCSo9EKZhMemSaQZhlRKWjD+qQ3qOM5h6nbbvY8tvP+hNZ22e6vaHgPDjFHTJ
	 Ydx+0VLimmzM7RJD+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1sU3Bf1arU-00JdG1; Thu, 19
 Sep 2024 09:01:39 +0200
Message-ID: <f8bab255-7e50-44cd-9476-882dd95ad9b8@web.de>
Date: Thu, 19 Sep 2024 09:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [v3 01/10] coccinelle: Add rules to find str_true_false()
 replacements
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 linux-hardening@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20240911010927.741343-1-lihongbo22@huawei.com>
 <20240911010927.741343-2-lihongbo22@huawei.com>
 <2aefba9e-f04e-4ee6-60cb-a139c0641ff1@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <2aefba9e-f04e-4ee6-60cb-a139c0641ff1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jEqiU0gukV4uEXAi+gshd8WqxAVEdRjHEbKB0XRk/Y8E/F/GU5y
 NE9EKVwuaO4aJjAS6Xw+55jP1l5XKs5rpcOVJn5xi4roc0fYPsl7jMBVMX5g/Ev2horjeS+
 nNSRs4bk1G9Ee1IYNRKcmggn2Vo32BTyrkhY3GyaynM4y+g3arcGUnLQx8UDRktmt5Lgfop
 UImmm4QRx3ZQk9NHhiFeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:huDVqKXeBJQ=;NaJruPCZunXNqMMwL9Q05MAD0Lz
 QIJuR3n4wddmg3FxfpWi+IF1GuJINt5eHf3mPy10bvSqAv6VLC81RMur7nhulFoz7cHqxfhid
 qhutfwodp3iS6zlc2wSoQz1mmN55J/Wxa56jhUGgwRz+cykle5zWwyYfM5myxWcs4DrHMTVKb
 93wNHsDkf/jhHp3KtkpNbd3/6Ag43tHEqRONCW4rygofWNZpTSdzaEX2Gz/7fK/f8jOMTifJV
 ROstlKEmP7v2JpzDq3FgCCziguamjzE01itHBZRL2SWttaL6w8JJm6+XHog0HmzFiSQKG1xr6
 LiBBeFi8gZMBCO2HHm7/MwuvVZxl4rGnqamaCDR5Qklo1vgL1JtQhepWUHSwXwdGmUQQf8gxA
 bRedJOw6Z6tX5gVWzoR0ueqGEIZkY29N8l0IB+KrEYNB+LUzK9quCNf7cU1nD23gDsIfO7ii0
 iCrJBAsE9Y7oPUzUrK0mVVK/M/HyeIIIBNRoOv1DHmMHIJi4ljFyMbSJM1m3cnuNgP88S8iKc
 7ZPjfd0mMXK7RY7NA0++xRyJNOf2wZanWkWVh2Z5vd6gM9u3Cv3F9BQC5UT4ilVf7muKf8AhA
 UPqSL8YK3DF1zPeLL94lPp3nzH+rEZhTUvv8fRfOkEO6GmiYLqKZUEWqOKZbKb+QVTxMLkZeK
 uhxKUe7DrRtyk8T8WoVIwbDRMYte3v9kiVSzljY8MFYPLgf48ICdhGe399W9Oi0b+OlrnRxqk
 IlFkV5VJMn1ic5k/TWp2r/PcSN4Fi7HA7I0+IGQvfF9qKB4TDdLXyB2Sb7QDH5u+csBIbyJnZ
 ixkJz5urrLkXXuv/xixjDGpA==

> The semantic patch is quite slow.  Actually it tests a large number of
> cases, eg where the parentheses are present and where they are not.

Can such development concerns trigger any adjustments for further
coccicheck configurations and provided SmPL scripts?

Regards,
Markus
