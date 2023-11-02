Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB27486
	for <linux-hardening@vger.kernel.org>; Thu,  2 Nov 2023 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zQxdPL5O"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69392B7
	for <linux-hardening@vger.kernel.org>; Thu,  2 Nov 2023 07:50:52 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SLmyc4dm5zMqTws;
	Thu,  2 Nov 2023 14:50:48 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SLmyb3LQhzMppBD;
	Thu,  2 Nov 2023 15:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1698936648;
	bh=46MvR33ToQtq+GKZ/zeDIFhOwJkpgIN4XpvCQA5qzoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zQxdPL5O1P4PynsfsTd7keBW914GsYcJ7Wm+g3CZPmcYMyOkwNQYmtLyMKDadzApZ
	 MPMK6TfngZXaAv1EwB82Hlc08m+X4G0mzwnH+VYaSNZEgwgJNwRYdC0oBSngxMEN6/
	 +iDAanTpUhSssvYITN9+VhYh/wK+obboCBlgMbtU=
Date: Thu, 2 Nov 2023 15:50:44 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Stefan Bavendiek <stefan.bavendiek@mailbox.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, kernel-hardening@lists.openwall.com, 
	linux-hardening@vger.kernel.org, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: Isolating abstract sockets
Message-ID: <20231102.MaeWaepav8nu@digikod.net>
References: <Y59qBh9rRDgsIHaj@mailbox.org>
 <20231024134608.GC320399@mail.hallyn.com>
 <CAHC9VhRCJfBRu8172=5jF_gFhv2znQXTnGs_c_ae1G3rk_Dc-g@mail.gmail.com>
 <20231024141807.GB321218@mail.hallyn.com>
 <CAHC9VhQaotVPGzWFFzRCgw9mDDc2tu6kmGHioMBghj-ybbYx1Q@mail.gmail.com>
 <20231024160714.GA323539@mail.hallyn.com>
 <ZUFmW8DrxrhOhuVs@mailbox.org>
 <20231101.eeshae5Ahpei@digikod.net>
 <CAG48ez0wQ3LFxZ2jWj1sTZngTg4fEmx1=dXYuRbMMFk5CiYVbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0wQ3LFxZ2jWj1sTZngTg4fEmx1=dXYuRbMMFk5CiYVbg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Nov 01, 2023 at 05:23:12PM +0100, Jann Horn wrote:
> On Wed, Nov 1, 2023 at 11:57 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Oct 31, 2023 at 09:40:59PM +0100, Stefan Bavendiek wrote:
> > > On Tue, Oct 24, 2023 at 11:07:14AM -0500, Serge E. Hallyn wrote:
> > > > In 2005, before namespaces were upstreamed, I posted the 'bsdjail' LSM,
> > > > which briefly made it into the -mm kernel, but was eventually rejected as
> > > > being an abuse of the LSM interface for OS level virtualization :)
> > > >
> > > > It's not 100% clear to me whether Stefan only wants isolation, or
> > > > wants something closer to virtualization.
> > > >
> > > > Stefan, would an LSM allowing you to isolate certain processes from
> > > > some abstract unix socket paths (or by label, whatever0 suffice for you?
> > > >
> > >
> > > My intention was to find a clean way to isolate abstract sockets in network
> > > applications without adding dependencies like LSMs. However the entire approach
> > > of using namespaces for this is something I have mostly abandoned. LSMs like
> > > Apparmor and SELinux would work fine for process isolation when you can control
> > > the target system, but for general deployment of sandboxed processes, I found it
> > > to be significantly easier (and more effective) to build this into the
> > > application itself by using a multi process approach with seccomp (Basically how
> > > OpenSSH did it)
> >
> > I agree that for sandbox use cases embedding such security policy into
> > the application itself makes sense. Landlock works the same way as
> > seccomp but it sandboxes applications according to the kernel semantic
> > (e.g. process, socket). The LSM framework is just a kernel
> > implementation detail. ;)
> 
> (Related, it might be nice if Landlock had a way to completely deny
> access to abstract unix sockets,

I think it would make more sense to scope access to abstract unix
sockets: https://lore.kernel.org/all/20231025.eecai4uGh5Ie@digikod.net/

A complementary approach would be to restrict socket creation according
to their properties:
https://lore.kernel.org/all/b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net/

> and a way to restrict filesystem unix
> sockets with filesystem rules... LANDLOCK_ACCESS_FS_MAKE_SOCK exists
> for restricting bind(), but I don't think there's an analogous
> permission for connect().

I agree. It should not be too difficult to add a new LSM path hook for
connect (and sendmsg) to named unix socket with the related access
rights.  We should be careful about the impact on sendmsg calls though.

> 
> Currently, when you try to sandbox an application with Landlock, you
> have to use seccomp to completely block access to unix domain sockets,
> or alternatively use something like the seccomp_unotify feature to
> interactively filter connect() calls.
> 
> On the other hand, maybe such a feature would be a bit superfluous
> when we have seccomp_unotify already... idk.)

seccomp_unotify enables user space to emulate syscalls, which requires a
service per sandbox. seccomp is useful but will always be delicate to
use and to maintain the related filters for sandboxing use cases:
https://www.ndss-symposium.org/ndss2003/traps-and-pitfalls-practical-problems-system-call-interposition-based-security-tools/

Anyway, I'd be happy to help improve Landlock with new access control
types.

FYI, TCP connect and bind access control should be part of Linux 6.7:
https://lore.kernel.org/all/20231102131354.263678-1-mic@digikod.net/
