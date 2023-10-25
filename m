Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E991A29F
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DEE111
	for <linux-hardening@vger.kernel.org>; Wed, 25 Oct 2023 10:22:37 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A6C3660B; Wed, 25 Oct 2023 12:22:35 -0500 (CDT)
Date: Wed, 25 Oct 2023 12:22:35 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jann Horn <jannh@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Stefan Bavendiek <stefan.bavendiek@mailbox.org>,
	kernel-hardening@lists.openwall.com,
	linux-hardening@vger.kernel.org
Subject: Re: Isolating abstract sockets
Message-ID: <20231025172235.GA345747@mail.hallyn.com>
References: <Y59qBh9rRDgsIHaj@mailbox.org>
 <20231024134608.GC320399@mail.hallyn.com>
 <CAG48ez2DF4unFq7wXqHVdUg+o_VYee012v0hUiGTbfnTpsPi0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2DF4unFq7wXqHVdUg+o_VYee012v0hUiGTbfnTpsPi0w@mail.gmail.com>

On Wed, Oct 25, 2023 at 07:10:07PM +0200, Jann Horn wrote:
> On Tue, Oct 24, 2023 at 3:46 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > Disabling them altogether would break lots of things depending on them,
> > like X :)  (@/tmp/.X11-unix/X0).
> 
> FWIW, X can connect over both filesystem-based unix domain sockets and
> abstract unix domain sockets. When a normal X client tries to connect
> to the server, it'll try a bunch of stuff, including an abstract unix
> socket address, a filesystem-based unix socket address, and TCP:
> 
> $ DISPLAY=:12345 strace -f -e trace=connect xev >/dev/null
> connect(3, {sa_family=AF_UNIX, sun_path=@"/tmp/.X11-unix/X12345"}, 24)
> = -1 ECONNREFUSED (Connection refused)
> connect(3, {sa_family=AF_UNIX, sun_path="/tmp/.X11-unix/X12345"}, 110)
> = -1 ENOENT (No such file or directory)
> [...]
> connect(3, {sa_family=AF_INET, sin_port=htons(18345),
> sin_addr=inet_addr("127.0.0.1")}, 16) = 0
> connect(3, {sa_family=AF_INET6, sin6_port=htons(18345),
> inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=htonl(0),
> sin6_scope_id=0}, 28) = 0
> connect(3, {sa_family=AF_INET6, sin6_port=htons(18345),
> inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=htonl(0),
> sin6_scope_id=0}, 28) = -1 ECONNREFUSED (Connection refused)
> connect(3, {sa_family=AF_INET, sin_port=htons(18345),
> sin_addr=inet_addr("127.0.0.1")}, 16) = -1 ECONNREFUSED (Connection
> refused)
> 
> And the X server normally listens on both an abstract and a
> filesystem-based unix socket address (see "netstat --unix -lnp").
> 
> So rejecting abstract unix socket connections shouldn't prevent an X
> client from connecting to the X server, I think.

Well it was just an example :)  Dbus is another.  But maybe all
the users of abstract unix sockets will fall back gracefully to
something else.  That'd be nice.

For X, abstract really doesn't even make sense to me.  Has it always
supported that?
