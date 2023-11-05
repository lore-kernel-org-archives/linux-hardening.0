Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95518B00
	for <linux-hardening@vger.kernel.org>; Sun,  5 Nov 2023 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="J6v+fcTe"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774FD9
	for <linux-hardening@vger.kernel.org>; Sun,  5 Nov 2023 13:27:58 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id zkesqAuzormQMzketqBHoe; Sun, 05 Nov 2023 22:27:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1699219676;
	bh=ZBxI7c/ZChbSFF3scIbmQ8sKou5OuuJXp2+47TLI3rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J6v+fcTecyDpqZOwya2BFcaG7NTjcE8SMRq2En1aoYFEWFQTUxdmoR3OjwMQki+sj
	 A3G+EzSeHG4AQ7HrknhbeQucLb9iLNWw0alr1vksWl6DOct0aWWbEKw7yJVBEaojpL
	 2ZQhq25gKfiXSGDQ7BIT8qUfFmKem/1dra+97rZuHqTLd9UWO1vd14hDgS/IxG/Jv4
	 sQUCtoTv4voh/tUQpSO/8vOOZlkCF7+MLX65eBagf3rtzUHlARjVXkbLY7UcUSADfu
	 bTZZnb1FNbN2v171oUpB/lmpCi+RLOrGPLVqmvPJnwqRGWfZyThSkY23NVSFnZgOS3
	 CJ3aIqoLiErSg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 05 Nov 2023 22:27:56 +0100
X-ME-IP: 86.243.2.178
Message-ID: <bcfc4079-2f50-4a7f-a4fa-65fcfb465e6f@wanadoo.fr>
Date: Sun, 5 Nov 2023 22:27:50 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
Content-Language: fr, en-US
To: Kees Cook <keescook@chromium.org>, Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
 <202309301342.5B5BED40A1@keescook>
 <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
 <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
 <alpine.DEB.2.22.394.2310012112560.3166@hadrien>
 <202310011405.7599BA9@keescook> <202310011421.C4F19D45@keescook>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202310011421.C4F19D45@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 01/10/2023 à 23:22, Kees Cook a écrit :
> On Sun, Oct 01, 2023 at 02:05:46PM -0700, Kees Cook wrote:
>> On Sun, Oct 01, 2023 at 09:14:02PM +0200, Julia Lawall wrote:
>>> Kees,
>>>
>>> You can try the following.
>>
>> Cool! Yeah, this finds the example:
>>
>> drivers/comedi/drivers/rti800.c:74: struct comedi_lrange: field at offset 0 is the counter for the flex array
>> drivers/comedi/drivers/rti800.c:83: struct comedi_lrange: field at offset 0 is the counter for the flex array
>> drivers/comedi/drivers/rti800.c:92: struct comedi_lrange: field at offset 0 is the counter for the flex array
>>
>> I'll run it on the whole codebase...
> 
> It found only the struct comedi_lrange instances, but that's good to
> know. :)
> 

Hi,

(removing most of people from the thread)


I found another one.

struct ocotp_devtype_data has a field 'num_entry' which is the number of 
entries in 'entry' flex array.


[1]: 
https://elixir.bootlin.com/linux/v6.6/source/drivers/nvmem/imx-ocotp-ele.c#L28
[2]: 
https://elixir.bootlin.com/linux/v6.6/source/drivers/nvmem/imx-ocotp-ele.c#L143

CJ
