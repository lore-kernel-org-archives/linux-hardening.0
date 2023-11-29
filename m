Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="o7QqF0Tb"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E102010CE
	for <linux-hardening@vger.kernel.org>; Wed, 29 Nov 2023 10:59:23 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id 8L6hrY5FKWcCI8PmMruWci; Wed, 29 Nov 2023 18:59:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 8PmLrcXnNGKIc8PmMr05Ry; Wed, 29 Nov 2023 18:59:22 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=65678a0a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7m0pAUNwt3ppyxJkgzeoew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=-ubsauMo1vhQ0g-4glIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7OI9D0eyAxHKpZTaNiARRfZBik1LQdu0fxFr+ZBYUKY=; b=o7QqF0TbfUWmnTNpbRbOD0FKmE
	XxBedNgtDThkbqTmx9RPT3YGhbug1lHYZ6yjmflddwTUikk07lTPqND2yl2U+5pKs/XBgQHLjuP+f
	gJjYczf5mW3iMd8268mMcupsn7pjclY38K1KwOSmVifcdUS/GCQEJizf8rKsjI86fCLeG+H55E3UF
	Am9Fq2vkVWju31xE5gqh8qGzc/OBqiNOyqIBryKfHQh23pSW/J3VdY6ppTBAIgOEn3xhkjlqKV545
	fMOY/7CScJLh4PUFQgP7kNVGChaVZ9ZYAhF8yZhY/3uz1BXvjzCRV6BiRqKfkfC7k19+PEcrfjPM6
	TzJZBYsQ==;
Received: from 187.184.156.122.cable.dyn.cableonline.com.mx ([187.184.156.122]:1245 helo=[192.168.0.28])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r8PmL-001xh8-1J;
	Wed, 29 Nov 2023 12:59:21 -0600
Message-ID: <a4890aae-2be8-42e3-9aa1-ee62f892553f@embeddedor.com>
Date: Wed, 29 Nov 2023 12:59:19 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference, address:
 0000000000000020
Content-Language: en-US
To: Dan Moulding <dan@danm.net>, sam@gentoo.org
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, toralf.foerster@gmx.de
References: <87jzq1lflc.fsf@gentoo.org> <20231128224816.6563-1-dan@danm.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231128224816.6563-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.156.122
X-Source-L: No
X-Exim-ID: 1r8PmL-001xh8-1J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.156.122.cable.dyn.cableonline.com.mx ([192.168.0.28]) [187.184.156.122]:1245
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGlDIhsU1ns7ro1OZeKXN+k4Zu/uvwB3AF7CWkCO+iwr28JlQ9nweY0Oas7cFSCAPo982yh1Fd4uuJwNfgsQPFATaAfCirUeSmr7NPROFi3PjhpG2gVB
 YG6N0mvqXkTSWSn4hPRjozhNNbQhR5lv/eaPnTDCFUG1JDmSCzTyjGKt7bJeMoUyo1IImX7qD0KstylKpNR/y6gsYHVMT2lGbmVJFJFOPvERbAKtJUtPiOBA


> the kernel source. But a quick (and possibly imperfect) grepping seems
> to show that struct neighbor was the only one used with
> __randomize_layout. So, I *think* it might be the only one that could
> cause a problem with the recent change to the randomize_layout plugin.

Yeah, I can confirm we don't currently have any other fake flex array
in a struct with __randomize_layout. :)

--
Gustavo
