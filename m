Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9B125DE
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F52D10E
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 06:46:10 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id AC26659E; Tue, 24 Oct 2023 08:46:08 -0500 (CDT)
Date: Tue, 24 Oct 2023 08:46:08 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stefan Bavendiek <stefan.bavendiek@mailbox.org>
Cc: kernel-hardening@lists.openwall.com, linux-hardening@vger.kernel.org
Subject: Re: Isolating abstract sockets
Message-ID: <20231024134608.GC320399@mail.hallyn.com>
References: <Y59qBh9rRDgsIHaj@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y59qBh9rRDgsIHaj@mailbox.org>

On Sun, Dec 18, 2022 at 08:29:10PM +0100, Stefan Bavendiek wrote:
> When building userspace application sandboxes, one issue that does not seem trivial to solve is the isolation of abstract sockets.

Veeery late reply.  Have you had any productive discussions about this in
other threads or venues?

> While most IPC mechanism can be isolated by mechanisms like mount namespaces, abstract sockets are part of the network namespace.
> It is possible to isolate abstract sockets by using a new network namespace, however, unprivileged processes can only create a new empty network namespace, which removes network access as well and makes this useless for network clients.
> 
> Same linux sandbox projects try to solve this by bridging the existing network interfaces into the new namespace or use something like slirp4netns to archive this, but this does not look like an ideal solution to this problem, especially since sandboxing should reduce the kernel attack surface without introducing more complexity.
> 
> Aside from containers using namespaces, sandbox implementations based on seccomp and landlock would also run into the same problem, since landlock only provides file system isolation and seccomp cannot filter the path argument and therefore it can only be used to block new unix domain socket connections completely.
> 
> Currently there does not seem to be any way to disable network namespaces in the kernel without also disabling unix domain sockets.
> 
> The question is how to solve the issue of abstract socket isolation in a clean and efficient way, possibly even without namespaces.
> What would be the ideal way to implement a mechanism to disable abstract sockets either globally or even better, in the context of a process.
> And would such a patch have a realistic chance to make it into the kernel?

Disabling them altogether would break lots of things depending on them,
like X :)  (@/tmp/.X11-unix/X0).  The other path is to reconsider network
namespaces.  There are several directions this could lead.  For one, as
Dinesh Subhraveti often points out, the current "network" namespace is
really a network device namespace.  If we instead namespace at the
bind/connect/etc calls, we end up with much different abilities.  You
can implement something like this today using seccomp-filter.

-serge
