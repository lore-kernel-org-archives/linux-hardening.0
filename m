Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE73191D3;
	Tue, 10 Feb 2026 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722926; cv=none; b=TuXiXjFsISqbY8doxdJ33Pxz/dHTug7jNc668Km+Im5CVacprqLE5KXeNmng8smeVQ8aywDIyKqWXxil1AYkeb2hPqCOnacOVd5HzmB0rCGOgNSi1yPTUK6llkmoi/BETxtPe/MY1NI5tPwf8HwkdSFRm3Q+gwVieD+mAXqU4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722926; c=relaxed/simple;
	bh=0wQNjIXnezQ/lZ4hm2GkVNftvYA31nHkanR2iarAeSY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dVOSDXeM2bZ6JN09osCo9xT+l4P0MMNnwAzDd++kH0a4nyY/fD+W5Ru3qCaoi05VOdW9gIdEo/SE12aD1vgq8/h00MWj02GOV5+aBGCQxddPCfVdBrv+6eaD6edKgtAWuKspox8LdDOH0fEYv5V4BUiv5GkifjpksyFn7iXqsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UeAr79u8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uh8/O+aD; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UeAr79u8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uh8/O+aD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 7B88813004CD;
	Tue, 10 Feb 2026 06:28:42 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 06:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770722922;
	 x=1770730122; bh=ivIZ+VARwnGRejR0pbNWDoFoQXA8UvaxKM1AHclAWKs=; b=
	UeAr79u8XKXO7I5Oyu4NYxz5KTyiJl+sSJ/V9DM3nY/27OgXOD2A6gTqPOWkmgRD
	yIP4PmXUj88KA8kY29aTW62e5751O3RX/jziqhrOjQuHLdkUwrGngLtQyUnWMSCO
	CzCbcPG7M/D+P4EFQcXPdUYQGyW7kv42p6hJIqdZNRVE6HhxJHfI3LZeYxBKgr+2
	S7GScyu1tGJQY3Q0gcpasMiTcTCStEvL2XMiZ6fbr/W/ZqH3lfWJeqIgYS79vqQD
	76Eq17eWxBy8xBL1+iestXmrOs0lcX9YKvvkfVPk284rCCL7v+gTZEukYHJPdPia
	cLSEtbOV7ggYU5jCGBXj7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770722922; x=
	1770730122; bh=ivIZ+VARwnGRejR0pbNWDoFoQXA8UvaxKM1AHclAWKs=; b=U
	h8/O+aD/uv9jF6DOA/XDMCj7RB54SColqsmvbaRenqGhGFgdv4reUiw98CUSV/9V
	ynUWOLZJlDzRzQbjVg//VwvZ0Lj/lxlaEY2DO8MxcXDissdV7ipyZZ/+icGbMouy
	9sqZ2s+IriJYiZnkGHQkL4r/LAC2Z3EqTK3xng/tNHeS+ivrZi5yswMWBkf/on69
	ADpFjAkqlZ4srq/WEMaU7OVtL/hRn2rqQglDlgog9kDaKHxknkt3jJOjO4S9FXKt
	lEPp71T4WzYGNROWiaNg92IAp6m/Tuj7ahemShHalfz7+A47Wza1kmT5H54VVumT
	XJOIQ9cRJ/+TYsN/MOC7w==
X-ME-Sender: <xms:aBaLaaQF7pOVWT0CkoE3XD07ZSqjB4Kg0onk-t84fqPg1zFV-mS2Yg>
    <xme:aBaLaamSKByk0s2TUmpVzONgivcNSNYvCZMyq-JSYFEURwBivFYBemdI8C9Q88O75
    MMC22-dqW4ZFStyVCHaDOFVpqkH1VX7q0VTTYI9B8HVuc9jF26iZyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjvghffhiguhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoh
    epsghrghgvrhhsthesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtkhdruggvshgr
    uhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhgsihiijh
    grkhesghhmrghilhdrtghomhdprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghr
    iiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrughunhhlrghpsehinhhfrh
    gruggvrggurdhorhhg
X-ME-Proxy: <xmx:aBaLaVBMGPflApMQvdCWFSVu1Vf9nSzbyvqNYYLAdMs71IWinpCupQ>
    <xmx:aBaLaQ-kghZldFHzEvHDCsG2v3OJicEYov4UaFdHXBkKO78tKk6KUA>
    <xmx:aBaLaQgQKlNxp1m2arEf8mp6Aeru7FA9EYu4u8ug7hLgPP266IzV3g>
    <xmx:aBaLaRac9FTeFJQSXdbIN6trLgIRh1qttyDKKswjGbMTLOijocYS1g>
    <xmx:ahaLaek-WbbTlhX6c6eOZmiYAxvUTSYkNXDFb7TTi4kI98O-X7MUOoTY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB8DC700065; Tue, 10 Feb 2026 06:28:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ays0886HgnbJ
Date: Tue, 10 Feb 2026 12:28:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bill Wendling" <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Marc Herbert" <Marc.Herbert@linux.intel.com>,
 "Uros Bizjak" <ubizjak@gmail.com>, "Tejun Heo" <tj@kernel.org>,
 "Jeff Xu" <jeffxu@chromium.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "John Stultz" <jstultz@google.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Brian Gerst" <brgerst@gmail.com>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 "Jan Hendrik Farr" <kernel@jfarr.cc>
Message-Id: <a4c3494c-5444-4cc5-b847-4e1754bf3d20@app.fastmail.com>
In-Reply-To: 
 <CAGG=3QXC7EH18mhJq6egqE6bvo8_KchPD_N4PeZ7Z7tLOv26-A@mail.gmail.com>
References: <20251121193957.1655580-1-morbo@google.com>
 <20251121193957.1655580-2-morbo@google.com>
 <d29ca795-ade3-454b-816e-46b5815a1444@app.fastmail.com>
 <CAGG=3QXC7EH18mhJq6egqE6bvo8_KchPD_N4PeZ7Z7tLOv26-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __counted_by_ptr macro
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026, at 12:00, Bill Wendling wrote:
> On Tue, Feb 10, 2026 at 12:41=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>>
>> This is every use of __counted_by_ptr() in linux-next at the moment.
>>
> I assume it's a git snapshot of GCC. :-) What does
> `scripts/cc-version.sh` produce for it?

It shows 'GCC 160000'

I see my mistake now, I tried to build the lastest snapshot
but accidentally checked out an older git commit on that
branch, which didn't work.

I retested with current HEAD now, and that does work.

Sorry for the confusion.

     Arnd
