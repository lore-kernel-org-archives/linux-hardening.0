Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9B131E5D
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606857; cv=none; b=SQ4FfdYYEhbA2Ck7cQUgQxgzTLkJslfGG/Y9tQAmHNtxjfX4v0ZOFZ0iYSNq6CyRB8oQW4So0JM5/fjy2mfiAsk9CPSwvhjYMFKd9P5Sh5tSrqHXz9j1Tcx11FaT1IpBwRLAWetfrd6WAfHy/Bgv+V7HR/XSKvo9LNRS1v+TX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606857; c=relaxed/simple;
	bh=am4Ng3rL5t852npAsV8y6BOWy1fVRkGuTTpFhiplqb8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HbdoCo3QZM+VciIPxqntYa4Mdix72pbKMKp1u0+JhWTg2qLArTXTQD30mvREIbcke5dEbJBX1licBVxM1Yu7+RX/IAvKMTJ0nK/AaBlrKEkhppgaTmyypmSQkBmEfU/RR+lQ/ChgKQ684r2e4Gt213U0dClqYGsYU1W27DxkNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=B3cjFOv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jL2JOfDw; arc=none smtp.client-ip=64.147.123.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="B3cjFOv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jL2JOfDw"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 8599C2B001E5;
	Thu, 22 Feb 2024 08:00:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 22 Feb 2024 08:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708606849; x=1708614049; bh=n4/M7vy4AR
	r+jl2e72cYY4Om1kbz4URjhjLljpwEbcQ=; b=B3cjFOv19/4ZCY0Th2TuZnUUSN
	nlTM1PUptQQWHW7SzXEnZkmEahqhhrq1aRxnyL3WnMoNVfMx4Ta/pKVLw0QXOuxd
	obKy5Gx0X4LV0404uEf68FmnFpedvID3s9pZTq+b60ZF/MaU/YBCTr82V2iiMP3G
	3yZuxYw7e29UKXIXyUGd3ZGw2aXlRgfV4XbArAxBIc+ghuZbP8XQrWvUiyu+BPIC
	BI1uJ5eUNHsoyg6kraOWinoQFoqRvCFYiFtCHC6GljI4QSlCWi+bEhyUafc5oeoa
	RUsLIM9CvGdMIHdQTAVFQqf0rXOgvb7yK3HPrkGxiPMjJs9U0KuyZgbc/VpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708606849; x=1708614049; bh=n4/M7vy4ARr+jl2e72cYY4Om1kbz
	4URjhjLljpwEbcQ=; b=jL2JOfDwYW/4tlfCMnCupJ43p03IZcWiwln1giVnJB0+
	5OOFBNFu64s+CbfzhpfnaReFSJefnZsaVzWetOZJL54Tezo1/Zzmg393B1aUvIuA
	ohl9op3F0/mGtYq4AwKk763IlpBRbw82ybXodWcSyzrPZl8ddBFtEvDB0Slq3rzk
	bOTGaFcJP6qkjELl0DQAnL+/p20wQeWFSOk6fkU421p5lugOatzx0iDR8mBrD3zU
	rd3F/2c3MvPw/gLPLDBM3yRYxIM3tYWh/fG6k2o0hd0axib5A0yGKfZpvudPBdHo
	5wJe0YuwiGLmNCn3T4b/P/8WnlEFSZGHVKWcpCRuSg==
X-ME-Sender: <xms:fkXXZYh5dJI_KimPKR3Hf6u5OuBYzfiwwGBqz6v16eID1U2t9fw8jQ>
    <xme:fkXXZRALHkI_iG1Hr-mOGk3Lj1J36U1e_smjbRWODkE8K7FDCe3KDRzkJBR8IX35_
    QBtyTyg7kmU8dOMJoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fkXXZQFu2y5gm06r_YD7beYYOaAiKYhdYCbyKEOz1L301hozwMkG6Q>
    <xmx:fkXXZZQoEqRPayXhv1Q54bNaw0oQeywwBudfm5zdjdrw5oiP0WvQHQ>
    <xmx:fkXXZVwD5ChNrgMbaL5QaYr3e7pBBNYL6NFz1WyAHB2UyDrbaBZuCA>
    <xmx:gUXXZffVUFxYysvw3JHcVLEZabjkY0qcvl0ASFnEqY-EKTYxn3cJNocp9K0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 60071B6008D; Thu, 22 Feb 2024 08:00:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19930c5a-f1ed-4b04-b69a-d7259966f020@app.fastmail.com>
In-Reply-To: <202304061930.4Au0PASm-lkp@intel.com>
References: <20230406000212.3442647-6-keescook@chromium.org>
 <202304061930.4Au0PASm-lkp@intel.com>
Date: Thu, 22 Feb 2024 14:00:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>, "Kees Cook" <keescook@chromium.org>,
 linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 "Andy Shevchenko" <andy@kernel.org>,
 "Cezary Rojewski" <cezary.rojewski@intel.com>,
 "Puyou Lu" <puyou.lu@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Linux Memory Management List" <linux-mm@kvack.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Alexander Potapenko" <glider@google.com>,
 "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Liam R. Howlett" <liam.howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Sander Vanheule" <sander@svanheule.net>,
 "Eric Biggers" <ebiggers@google.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
Content-Type: text/plain

On Thu, Apr 6, 2023, at 13:19, kernel test robot wrote:

> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: 
> https://lore.kernel.org/oe-kbuild-all/202304061930.4Au0PASm-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> ld.lld: error: undefined symbol: __fortify_panic
>    >>> referenced by fortify-string.h:208 (include/linux/fortify-string.h:208)
>    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlist_count)
>    >>> referenced by fortify-string.h:208 (include/linux/fortify-string.h:208)
>    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlist_search)
>    >>> referenced by fortify-string.h:208 (include/linux/fortify-string.h:208)
>    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlist_get)

I get a related build failure from the same commit:

arch/arm/boot/compressed/misc.c:157:6: error: no previous prototype for '__fortify_panic' [-Werror=missing-prototypes]
  157 | void __fortify_panic(const u8 reason, size_t avail, size_t size)

      Arnd
