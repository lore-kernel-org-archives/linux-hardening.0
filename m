Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1022625;
	Thu, 20 Jun 2024 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860237; cv=none; b=E1ERnnPZ0LhmJTPP4Hz1LMmubxj/E9vYSVbSKWwUU56ykW7ON4kZxZ2rH7DX1kbvtVt01gdRXelvwGBnafdYEGMgItpUDBDaCGK1dDEU3HT2U6aue46o2w663+S+z0vznl6HAkUZkBPIx6fyqpt14JMN5HcsY2HWR6S6fLHW3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860237; c=relaxed/simple;
	bh=EcoZJnOw4ZxQicG1ODL6MLtAc4U2F8syA+1dK4SXrlE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=omWp2Jt1quVNBFVm1QBqroSnsCFlgQmjquH+dNQTfWtp5i+gbQ5xc5AtF/cr8YlumE1MZUAVTNaNAypdJn9XYm1rCKZZswo6h7IoNFdnMgJ2j3ToieMsJyPUKpyzfbbPgyUJyEz7uZtS/SVmPKT44G3LBSoAMZofg15YP0WfMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=h0jXyEqc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDIK+DYQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="h0jXyEqc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDIK+DYQ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7EDEB1380508;
	Thu, 20 Jun 2024 01:10:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 20 Jun 2024 01:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718860234; x=1718946634; bh=oOvBZk5ku2
	PHWJwOBdeAamQaGtBAcJuFlI+eQulJJ/g=; b=h0jXyEqcRFm3Hi22xQ+m2VpoUE
	teCVADhBueEOqre6hUAZDNz9c7t2pIHWTblOXrTvh1c9WAuih+sekLy8D8YLPuy9
	EyiLQOFJsE24JVv5PVVPJ6aegqsw9vzA/g8Eoedaa19JiylOWPxiFYV5Ep+Ggp/H
	NWotnuSjeX+hol5p4ghiMw8eHa01WMMSl9pmD561f6bC8oePben+DuLAjTzdlyYw
	zd4C7dgylUsgmPJkCZdLnsGsMDhr/sThH4KbhqGvLI5j6GGNNO98nU8nu2H4ykUI
	7BmcDP4fLZNR/TlhBd9uaT8hQBXpzgeJGp7aQbd7eQNgLYv3zS7MYnjS8qGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718860234; x=1718946634; bh=oOvBZk5ku2PHWJwOBdeAamQaGtBA
	cJuFlI+eQulJJ/g=; b=YDIK+DYQVSAZsVlNHkyZxYleCK505KY/U/rQoAaT8u4u
	NGYRrG22n1I0ASTtmF8swqQZpRO7FrJwazf0YFZ6SRHTpuYS9GwOhLl4VrMfT0/E
	Tn4lx9Ue4RNlJqqK/pkSgIHgU+Gcm5UIx6au27jadKGJdgJY+gjqFAn7HQnpxkAq
	akcjwD6QAbuaUNCqZ63KMSDrf164sGa9+t7AbtbUn25OsHWUScjqePhlu/z6SLVV
	f49PgIm/yLWg3smw/xMO/UR44aqcUVrEnWWDOWEpgdPJ8qXaoYNh73EQvbpR5Jy6
	nggfX5r6OgDOvazKcjl3+/Ne65tE0aK1iJ6kHXatGw==
X-ME-Sender: <xms:yrlzZsXfhMHWLqRCrCPOK53Pbu6PPue9mKKo4AI6hYkiMOI1Nw5j0A>
    <xme:yrlzZglhMC5JetbHsGZEYC7aAq2IjDjrFY5zsS4YKs4IFCHzQN6_APR773UpWj751
    72KlrkMKvxOtqpWMGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:yrlzZga_c1vis0bOUDGP6ANeihwp5WlYQoDine7an1U4KRFU127giA>
    <xmx:yrlzZrUlU4ChJ8D2Jr0SE3PFhtfYFoJEQYLO-RlpUwzDgkyzWiZq-w>
    <xmx:yrlzZmlwZ0xCQPCCw4MCFjdHLvoSBXhrOVInOh6HuWucbLq63l1kDA>
    <xmx:yrlzZgfPu6arFSV2RA8BqkjtvytabBWNGVqPsTwohX9D8h1d2RoTBw>
    <xmx:yrlzZohudk4mJXONopTxuL3f8xOQ1gQ27SxwbHmOOR_k1EONWOchV295>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3AFAFB6008D; Thu, 20 Jun 2024 01:10:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <345dff33-86f0-4de3-90e3-9e3a13f20875@app.fastmail.com>
In-Reply-To: <202406191414.67C589A@keescook>
References: <563b8f82-9865-40ae-85d3-055b3bcda7d6@quicinc.com>
 <202406191343.D361BC137@keescook>
 <f1f08297-e8c7-4673-88b5-e9b6bff69371@app.fastmail.com>
 <202406191414.67C589A@keescook>
Date: Thu, 20 Jun 2024 07:10:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>
Cc: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 linux-hardening@vger.kernel.org, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: mips gcc plugin issues
Content-Type: text/plain

On Wed, Jun 19, 2024, at 23:17, Kees Cook wrote:
> On Wed, Jun 19, 2024 at 11:12:25PM +0200, Arnd Bergmann wrote:
>> On Wed, Jun 19, 2024, at 22:50, Kees Cook wrote:

>> The problem here is that a gcc plugin links against the
>> compiler, not against code produced by it. I'm linking the
>> crosstool compilers statically against libraries as much as
>> possible in order to make them more portable between distros,
>> but the downside of that is that plugins will only work in
>> the environment that I was using to build these toolchains.
>> 
>> My build environment is an older Debian (in order to be
>> portable to old glibc versions), but with the system compiler
>> updated to gcc-13 (since x86 libgcc cannot be cross-compiled
>> with an older compiler).
>
> Can the crosstools remove the plugin support? That seems like the best
> solution. Kconfig test for plugin availability with:
>
> 	depends on $(success,test -e $(shell,$(CC) 
> -print-file-name=plugin)/include/plugin-version.h)

Good idea, yes. I still have to upload gcc-14.1 and gcc-13.3 binaries
anyway, so I'll try turning off plugin support when I build it.

      Arnd
