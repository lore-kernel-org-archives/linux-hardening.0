Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F618633
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horotw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horotw.com
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4TDL7V3YB0z8ZCf;
	Mon, 15 Jan 2024 18:21:26 +0000 (UTC)
Authentication-Results:mors-relay8204.netcup.net; dkim=permerror (bad message/signature format)
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4TDL7V2rD0z8ZC4;
	Mon, 15 Jan 2024 18:21:26 +0000 (UTC)
Received: from mx2fc9.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4TDL7S3GTpz8sgK;
	Mon, 15 Jan 2024 19:21:24 +0100 (CET)
Received: from webmail01.netcup.net (unknown [46.38.249.153])
	by mx2fc9.netcup.net (Postfix) with ESMTPA id D2A9480587;
	Mon, 15 Jan 2024 19:21:19 +0100 (CET)
Authentication-Results: mx2fc9;
        spf=pass (sender IP is 46.38.249.153) smtp.mailfrom=mail@horotw.com smtp.helo=webmail01.netcup.net
Received-SPF: pass (mx2fc9: connection is authenticated)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jan 2024 19:21:19 +0100
From: mail@horotw.com
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-hardening@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>, Salvatore
 Bonaccorso <carnil@debian.org>, Linux Memory Management List
 <linux-mm@kvack.org>, William Kucharski <william.kucharski@oracle.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
In-Reply-To: <ZaVi4ij0jgEz+isx@casper.infradead.org>
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
 <87il3ur1ik.fsf@gentoo.org> <ZaVi4ij0jgEz+isx@casper.infradead.org>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <07c348caaf6b4c457ab4b452f53ed048@horotw.com>
X-Sender: mail@horotw.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <170534288009.5614.902050737944274230@mx2fc9.netcup.net>
X-Rspamd-Queue-Id: D2A9480587
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: OADe2qnkK3tKCl+3U9X7DaYeKFklU6iktFcEDZP9aA==

Am 15.01.2024 17:52, schrieb Matthew Wilcox:
> On Mon, Jan 15, 2024 at 04:40:36PM +0000, Sam James wrote:
>> mail@horotw.com writes:
>> > Hey, I read that ASLR is currently (since kernel >=5.18) broken for
>> > 32bit libs and reduced in effectiveness for 64bit libs... (the issue
>> > only arises if a lib is over 2MB).
>> > I confirmed this for myself but only for the 64bit case.
>> >
>> > I saw that this issue is being tracked by ubuntu
>> > (https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1983357).
>> > If this is the wrong place and I should instead report it elsewhere I
>> > am very sorry.
>> 
>> See also https://bugs.debian.org/1024149. Unfortunately, I don't
>> think the issue found its way upstream until now (thanks).
>> 
>> CCing relevant maintainers (per the Debian bug).
> 
> You know, my email address is all over that commit and the doofus who
> "discovered the vulnerability" didn't even have the courtesy to let
> me know.  I've had several private emails about this over the last few
> days and I just don't care.  Who's running 32-bit code and cares about
> security?  32-bit kernels are known-vulnerable to all kinds of security
> problems, and I think this is the least of your worries.
> 
> This was intended to happen, it's not a surprise.

Hi,
first of all I am very sorry, I didn't realize I should have contacted 
you
first (I'm not the one who found the bug initially), I will do it
differently in the future.

Unfortunately, my knowledge is not sufficient to judge how bad it is 
that
32bit effectively has no ASLR support anymore.

64bit is also affected, even though there are probably more than enough
bits left there? I have since seen that both Arch and Ubuntu seem to 
have
"patches" in place 
(https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/commit/3904bcb32cc58c10232fb618bf96c1b43b0bc9d7)
in which they set the `CONFIG_ARCH_MMAP_RND_BITS=32` and
`CONFIG_ARCH_MMAP_RND_COMPAT_BITS=16`, I'm not sure if this is a good
result or if it will cause other problems.

Again, I apologize if I caused any inconvenience.
