Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C132D3727
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080332; cv=none; b=GaBbo9xcoPl0NInnTnWxCP4QDUc5HSS0awmpoNw7CebKczj4SE8ckfFncI5AsJONDLT9MtJsM9jPg5qv1CEJJSkqDav6t+h7MyQNKnidWkj9YxsoK52QTZg4BaQj5OUH+C1mXBDFcbBklx3XTitEcPqieKhCgQDJZjpeK9gg5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080332; c=relaxed/simple;
	bh=2aMBWjpKHG4l6a39ZgwdL0cute2JFyOjPolxG7XWERc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFGful5vp3Texyv6S9N0IdUQZ+3IsWwpS/a0DkxH+oUjERXwANZamdZl/DTIMtfs93cgndBVO++gzOECi7FVMF5qQssH0oKDkzKTxl+xheYLi+zoDk7LPaqmif+1rOamc7Vhn+w8K88SxMjQo+NzLI2Rs1/pHo7FaqyMxI3sk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=O6MIOhTO; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="O6MIOhTO"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id zd1cvxA1TVCBNzfBlvZpXr; Mon, 09 Mar 2026 18:18:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id zfBHvHeDK2l0kzfBIv6PM8; Mon, 09 Mar 2026 18:18:16 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=69af0f04
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=V5vwHjfW8xl6N5DwPO4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZqoQ9lkNkezuo7Panmj7PEOH/0BqG4BNzGHgiJvpZQg=; b=O6MIOhTOtWuHpbIUV7Upkm4xg4
	IxSawP73Ba3uRUo/hucIWnKb1m7V19GKWOv/RjsHxCDewtYancmIVQ3GInTbhJhcoYGJZdRTE7nCT
	AYYcN4wEn+YsDj1XXWoipZMFAYrBZUKn+J61SQvr8HVrPK+TD2ha2E5yVpr5oeqbGpLAVy9LD1Ncs
	KSaFWfG7yn7h7jmb93WoQph4UqTNO/ZCW41v4LGXc/uYAfYrxC3VUK3QbMq72QYV30aCjkEuIRAEb
	Errd3DS9OKG5o+hNdB6X3lSMw/y31OqCIS/3606QouEpSIUw0qZ6B+TrP/e0PI+J/FATulK/BOovE
	DgVSmxlw==;
Received: from [177.238.16.13] (port=39494 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vzfBG-00000001N0A-4Add;
	Mon, 09 Mar 2026 13:18:15 -0500
Message-ID: <7dac0a99-0883-4ec1-9bfd-49b659bd38e6@embeddedor.com>
Date: Mon, 9 Mar 2026 12:17:39 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: msc313: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
 linux-hardening@vger.kernel.org, gustavoars@kernel.org,
 Romain Perier <romain.perier@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 "moderated list:ARM/MStar/Sigmastar Armv7 SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260308021535.48098-1-rosenp@gmail.com>
 <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
 <CAKxU2N9JbAzEYfmLpbw5b9Y6MsYUZ1FfLirfy8Hg8MCOUY6PAg@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAKxU2N9JbAzEYfmLpbw5b9Y6MsYUZ1FfLirfy8Hg8MCOUY6PAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vzfBG-00000001N0A-4Add
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:39494
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIzxb7HKliMGegT/tERT7O2MBPVB8BopusCgfFulngf7CS/7US9Uf5G+l55hEzKB2JjAui1aBugzggVpk/PLskx3n8g+c3DCbPVElplgYx9ldnDa7VuX
 n/UjPz64M/cmU1PhCdxiIwHeuVxJHbWuEykym/SA5FgLYX4WCt0cYACdc7LMUN/oXFKUROFeqeYPDfp0XonGawZ9ALqNKr0wbYZsnvOeBSvDAGUgGHtpXSMy



On 3/9/26 10:27, Rosen Penev wrote:
> On Sun, Mar 8, 2026 at 5:06 PM Linus Walleij <linusw@kernel.org> wrote:
>>
>> On Sun, Mar 8, 2026 at 3:15 AM Rosen Penev <rosenp@gmail.com> wrote:
>>
>>> Use a flexible array member to combine kzalloc and kcalloc.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> (...)
>>>   struct msc313_gpio {
>>>          void __iomem *base;
>>>          const struct msc313_gpio_data *gpio_data;
>>
>> Do you wanna add:
>>
>> const unsigned int saved_size;
> So in the code there's
> 
> for (i = 0; i < gpio->gpio_data->num; i++)
> 
> which is equivalent to match->num.
> 
> __counted_by doesn't support pointers AFAIK.

We actually have __counted_by_ptr().

-Gustavo

