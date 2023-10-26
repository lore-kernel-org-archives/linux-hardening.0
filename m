Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867432E41F
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="h6cR5JYN";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Y6dY9H2A"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3EA128
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1698330470;
	bh=+AVbEQ2cO0W9NNjiJtJkceR113CnWKAa4egRigHhpC8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=h6cR5JYN2ZWd9xnbjDhtTfiqFnYa7QwdfKSvUPHy2sPmCvLqnUWcTcYNzMcg+2QuQ
	 B7yAAh9KNG9PMgTSwpZDR7BSNH2ogrBNpVHMBnfh9kXusJbz1ED0sLguYX36OkdewS
	 DSpW/5oH06539YK83ggl+fQt8QRx7dOo/t2MQRUE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 248311287229;
	Thu, 26 Oct 2023 10:27:50 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ZZkmk4Z3gm94; Thu, 26 Oct 2023 10:27:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1698330469;
	bh=+AVbEQ2cO0W9NNjiJtJkceR113CnWKAa4egRigHhpC8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Y6dY9H2Ag71Glx/YfwRdXuukMdycq0MxM73+lD+vaQqdcz4au5+rNKmd/9D7ptupA
	 QM7lQ0BOpVCJE2L0eyXBZA93gOyWaok2k8pGROHfh6X2YlIKXyQnqNYudbPqejHGVj
	 9iBvcEpE9yOctDEZApzyqJziWi6xU6Gayw/agEZQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 992DA1281005;
	Thu, 26 Oct 2023 10:27:47 -0400 (EDT)
Message-ID: <f6372ec20b47624799546130e9170bf9ff1d22a5.camel@HansenPartnership.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Lunn <andrew@lunn.ch>, Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt
 <justinstitt@google.com>,  Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Date: Thu, 26 Oct 2023 10:27:45 -0400
In-Reply-To: <c7445b16-27c9-4182-8b0a-4272ddd2d341@lunn.ch>
References: 
	<20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
	 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
	 <20231020044645.GC11984@lst.de>
	 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
	 <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
	 <c7445b16-27c9-4182-8b0a-4272ddd2d341@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2023-10-26 at 15:44 +0200, Andrew Lunn wrote:
> > > > [1]:
> > > > https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> 
> I found that https://elixir.bootlin.com/linux

That's a 404, I think you mean

https://elixir.bootlin.com/linux/latest/source

>  is the best way to find Documentation for functions and structures.
> I would suggest try it first, and only when what fails to start using
> grep.

I just tried it with system_state and it doesn't even find the
definition.  I think it might be because it has annotations which
confuse the searcher (it's in init/main.c as

 enum system_states system_state __read_mostly;

).  If there's any meaningful doc about it, elixir also doesn't find
it.

James
 
