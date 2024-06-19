Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF718249ED;
	Wed, 19 Jun 2024 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831569; cv=none; b=YxjzzBP9ibF3JGQoGtLHEgdenAVsEUGVuLhAkIN7KLoX8Xigl/A2bIGAofOBdariXXR0vwZ+sqpAq2GMhfMq6a37AxLACVVh/J0pkixKi2LuySEqJCe/Z+A19RjjQ4t9UIkIx3YgzRcmUH7K1RwVcoF9Wiv/vS01QoWqh/gQ+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831569; c=relaxed/simple;
	bh=Yzq8tlLhy+Hs+OPsscHhYt5rgosZvrRijLnsOQOy4qo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aBzNqeDe9KvZOuhPHhIetKNreWtuBbyjWZO6yfb3x3zcPKq0pn2tQl77IN0hA4VSpqxne+Mzz1XqzSIJhWoH6rWIQ6SthwWMa69QI5QTiFMd2oA4Vw7XuPAjSNaM4IXIMcBHkroPOxm0UcNxw0PJWuPd0wZSZJwMBbkFSdwixjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mYKxzjdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nkUGAZsa; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mYKxzjdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nkUGAZsa"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 03A1D1380105;
	Wed, 19 Jun 2024 17:12:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 19 Jun 2024 17:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718831566; x=1718917966; bh=f1FTl8FPRm
	88cU0dNzu5X9mEf0mO3ktMxGHVAswcrGc=; b=mYKxzjdIW/d5bfr+PGY2Tbt6S+
	OAw0oGIrQXhy+vFQOIv3JRZM225QYKeQcgfO0RlykunBLzgkgeDFRVuTJuGO0gqD
	P/xG9vG+Ss5H14Mh1MDVf6sOQZMi49xzT+xvPkd372n9R9VtDaoJ6pgiGk2Y1SxV
	FRxdbymhlR1W4+mi/XheSCb92TgD1FUj5hHcVe0L7M6fT3Xkl2UEHxTQXvpBS2Q1
	DZWNJWu3RPnxRHlLMLlWqi6Gk3IYDGYVoCwhM9pmYnRuci+9GcPBKNri6LNDPcse
	m1lSwaF+gjybsIgt9xwILlaIKIw+gGfN8j6513PgQU8MKQ5iJ9gneI1cgKFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718831566; x=1718917966; bh=f1FTl8FPRm88cU0dNzu5X9mEf0mO
	3ktMxGHVAswcrGc=; b=nkUGAZsaySpnK5xf5sPKsO2Bqt+BF+JEEAq0MHj+yLWr
	OX1YF8WkPOlvcy71hCvat5CjrsxTXFOpNeWW0jUQ6Az7JupJggDO3PKLfT+QUnnb
	T19+ujHQHEmntpKkoEN0fPn7G1VEskrqYZSskOl+gx8B0N5catlwNp3YkWJNJ4u1
	uh9Bggs70Do84+5cSyAh+aBCDh6LjTGbpcqkUd31BMX0xOf1eXABXwDQLfUmVWr3
	PmETs2QlOtIa5SCC/07hPusPgX7XDcLoqbki8sQHiqhIFGUKxlA6PooWwLfZbYLB
	B9bA5Z7pvl8zOrZo/vZ/wP8JjRMnJx3RXKig27bW6g==
X-ME-Sender: <xms:zklzZrSbtCKv1pcGzrP7oAGEgfwWPs2Q9wnodpop6SojP8OWQr4JOQ>
    <xme:zklzZswfsPQNNABFxV9yj1ccyLO7BWOwco_VynmAnuGtLsWPon3CPn4hB-A5yiy6T
    JV6jNIzdKyt1pxvExo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zklzZg0q_5pWAuTzytzJbKxUZ7A3wlqd0uWWeEPcsHBjnRdR91nQLg>
    <xmx:zklzZrABTI26EdxiFeGInD1Y1Xm226U-8O0EIqPs-ZfIxSWJzl5OrA>
    <xmx:zklzZkicZN28Wy8W9DRld4MLKJqEGLJJKSQYAuPWjP4W3hoNtPA8gw>
    <xmx:zklzZvrWhauXqIJ7coLzf0JqE40YJ1TD5jvZXj9gl8naRZ513_fLJw>
    <xmx:zklzZtthkHoG-6FSPQbVgxbHKEkTsR2osXjyG4iY7Dam_SDvA5uw-sqt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AF476B6008D; Wed, 19 Jun 2024 17:12:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1f08297-e8c7-4673-88b5-e9b6bff69371@app.fastmail.com>
In-Reply-To: <202406191343.D361BC137@keescook>
References: <563b8f82-9865-40ae-85d3-055b3bcda7d6@quicinc.com>
 <202406191343.D361BC137@keescook>
Date: Wed, 19 Jun 2024 23:12:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Jeff Johnson" <quic_jjohnson@quicinc.com>
Cc: linux-hardening@vger.kernel.org,
 "open list" <linux-kernel@vger.kernel.org>
Subject: Re: mips gcc plugin issues
Content-Type: text/plain

On Wed, Jun 19, 2024, at 22:50, Kees Cook wrote:
> On Tue, Jun 18, 2024 at 04:41:01PM -0700, Jeff Johnson wrote:
>> I see the following in my .config:
>> CONFIG_HAVE_GCC_PLUGINS=y
>> CONFIG_GCC_PLUGINS=y
>> CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
>> CONFIG_GCC_PLUGIN_RANDSTRUCT=y
>> 
>> So I'll turn those off, but just want to flag that this issue exists.
>> Seems either the plugins should work or the allmodconfig should turn them off.
>
> Well, the plugins work with all the other compiler versions all the
> various CI systems use. :) For example, I don't see this with distro
> cross compilers:
>
> $ mipsel-linux-gnu-gcc --version
> mipsel-linux-gnu-gcc (Ubuntu 12.3.0-1ubuntu1) 12.3.0
>
> I suspect this is a problem with the kernel.org crosstool builds? I'm
> CCing Arnd, who might know more about this.

Yes, this is a known problem, and I don't think there is a good
solution for it, compiler plugins on cross-compilers are inherently
fragile.

The problem here is that a gcc plugin links against the
compiler, not against code produced by it. I'm linking the
crosstool compilers statically against libraries as much as
possible in order to make them more portable between distros,
but the downside of that is that plugins will only work in
the environment that I was using to build these toolchains.

My build environment is an older Debian (in order to be
portable to old glibc versions), but with the system compiler
updated to gcc-13 (since x86 libgcc cannot be cross-compiled
with an older compiler).

The long-term solution of course is to replace all the
gcc plugins with some other way of getting the same
features, but that will still take some time.

     Arnd
