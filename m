Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D52264B2;
	Mon,  7 Jul 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921617; cv=none; b=fYI7vT/GhaH+RpEs1jtKkuiVehhzfOEUkXwMnIO6HWY1Nok2vjuRZUOQCdXksRdhWHco2l0tePJ90v4SN7rmSIpWChZ+SvlX16BkYLpwaWyZtPUQKqA3XsXlG/vkhg2dHBBqzTFZlFlwkKex2PxkitgJM4Hlg3Tmyx7WZAlUrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921617; c=relaxed/simple;
	bh=/eVrzMVvZvb4CQjSxi2c2jJBEuGwM07+lVQlQsN89Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iqvrdoew4RMqCNr8tlHtkz/KPN3C7t4GikiP0CtW39pBKfrR4ht39ikif0tynQGbWUZEM8lw5DzRR0Q3YK8MyqKvsr8QK2oTnVLuntBU0OL+dVbh5af/CxriKWULJfdMQnmpSQhs9wC+lMyR+c+zXGiltGz0cqb4FopKexMIc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUJz70kr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUJz70kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9460EC4CEE3;
	Mon,  7 Jul 2025 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751921616;
	bh=/eVrzMVvZvb4CQjSxi2c2jJBEuGwM07+lVQlQsN89Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUJz70krZFt5UOCTS/RpEpL0p0exZ55UpeLHK0i2P0UGnVS6oy2RRmZ1vBTpqsF6x
	 dOHlghUi6uhSR6tYoZoLvgJdmp/OorAeMm5KTSUdljk3fASW6pITg6xbgxCLb6mAis
	 aFutNIc8g0PJZcBD2IfbgdGYPUrJGzPkD/+yNJwEV5e8kV0Y6IlbnGeY4/0NSrf6qw
	 pGZQU5mlahtWdyM0wF9rVkmpAhU4IBxVxZbo7tYltcNXPApiIYED8UJgN4tmjzWYkw
	 9bmFzZpgo8qrSk7CW7QjKpw+/L14P2CnCwspbePPBwPxe/mykQ8CZx7rOVun3bd/Wx
	 dm1vpbe3baSfQ==
Date: Mon, 7 Jul 2025 22:53:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <t3wv6hlt7quhab7qqvxbx6zn4rh2oo6466urtu6tmnix63ju7v@hiwhnb5l4twf>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>
 <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
 <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>
 <gvckzzomd7x3cxd7fxb37b6zn4uowjubpyrnvj7ptzz3mr3zq2@xovzgew63mxr>
 <CANpmjNO0_RAMgZJktaempOm-KdY6Q0iJYFz=YEibvBgh7hNPwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v74lbtuwitce4ome"
Content-Disposition: inline
In-Reply-To: <CANpmjNO0_RAMgZJktaempOm-KdY6Q0iJYFz=YEibvBgh7hNPwg@mail.gmail.com>


--v74lbtuwitce4ome
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>
 <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
 <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>
 <gvckzzomd7x3cxd7fxb37b6zn4uowjubpyrnvj7ptzz3mr3zq2@xovzgew63mxr>
 <CANpmjNO0_RAMgZJktaempOm-KdY6Q0iJYFz=YEibvBgh7hNPwg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANpmjNO0_RAMgZJktaempOm-KdY6Q0iJYFz=YEibvBgh7hNPwg@mail.gmail.com>

Hi Marco,

On Mon, Jul 07, 2025 at 09:08:29PM +0200, Marco Elver wrote:
> > > > > Did you run the tests? Do they pass?
> > > >
> > > > I don't know how to run them.  I've only built the kernel.  If you =
point
> > > > me to instructions on how to run them, I'll do so.  Thanks!
> > >
> > > Should just be CONFIG_KFENCE_KUNIT_TEST=3Dy -- then boot kernel and
> > > check that the test reports "ok".
> >
> > Hmmm, I can't see the results.  Did I miss anything?
> >
> >         alx@debian:~$ uname -a
> >         Linux debian 6.15.0-seprintf-mm+ #5 SMP PREEMPT_DYNAMIC Mon Jul=
  7 19:16:40 CEST 2025 x86_64 GNU/Linux
> >         alx@debian:~$ cat /boot/config-6.15.0-seprintf-mm+ | grep KFENCE
> >         CONFIG_HAVE_ARCH_KFENCE=3Dy
> >         CONFIG_KFENCE=3Dy
> >         CONFIG_KFENCE_SAMPLE_INTERVAL=3D0
>=20
>                      ^^ This means KFENCE is off.
>=20
> Not sure why it's 0 (distro default config?), but if you switch it to
> something like:

Yup, Debian default config plus what you told me.  :)

>=20
>   CONFIG_KFENCE_SAMPLE_INTERVAL=3D10

Thanks!  Now I see the tests.

I see no regressions.  I've tested both v6.15 and my branch, and see no
differences:


This was generated with the kernel built from my branch:

	$ sudo dmesg | grep -inC2 kfence | sed 's/^....//' > tmp/log_after

This was generated with a v6.15 kernel with the same exact config:

	$ sudo dmesg | grep -inC2 kfence | sed 's/^....//' > tmp/log_before

And here's a diff, ignoring some numbers that were easy to filter out:

	$ diff -U999 \
		<(cat tmp/log_before \
			| sed 's/0x[0-9a-f]*/0x????/g' \
			| sed 's/[[:digit:]]\.[[:digit:]]\+/?.?/g' \
			| sed 's/#[[:digit:]]\+/#???/g') \
		<(cat tmp/log_after \
			| sed 's/0x[0-9a-f]*/0x????/g' \
			| sed 's/[[:digit:]]\.[[:digit:]]\+/?.?/g' \
			| sed 's/#[[:digit:]]\+/#???/g');
	--- /dev/fd/63	2025-07-07 22:47:37.395608776 +0200
	+++ /dev/fd/62	2025-07-07 22:47:37.395608776 +0200
	@@ -1,303 +1,303 @@
	 [    ?.?] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
	 [    ?.?] rcu: srcu_init: Setting srcu_struct sizes based on contention.
	 [    ?.?] kfence: initialized - using 2097152 bytes for 255 objects at 0x=
????(____ptrval____)-0x????(____ptrval____)
	 [    ?.?] Console: colour dummy device 80x????
	 [    ?.?] printk: legacy console [tty0] enabled
	 --
	 [    ?.?] ok 7 sysctl_test
	 [    ?.?]     KTAP version 1
	 [    ?.?]     # Subtest: kfence
	 [    ?.?]     1..27
	 [    ?.?]     # test_out_of_bounds_read: test_alloc: size=3D32, gfp=3Dcc0=
, policy=3Dleft, cache=3D0
	 [    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 [    ?.?] BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0x??=
??/0x????
	=20
	 [    ?.?] Out-of-bounds read at 0x???? (1B left of kfence-#???):
	 [    ?.?]  test_out_of_bounds_read+0x????/0x????
	 [    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 [    ?.?]  ret_from_fork_asm+0x????/0x????
	=20
	 [    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	=20
	-[    ?.?] allocated by task 281 on cpu 6 at ?.?s (?.?s ago):
	+[    ?.?] allocated by task 286 on cpu 8 at ?.?s (?.?s ago):
	 --
	 [    ?.?]     # test_out_of_bounds_read: test_alloc: size=3D32, gfp=3Dcc0=
, policy=3Dright, cache=3D0
	 [    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 [    ?.?] BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read.cold=
+0x????/0x????
	=20
	 [    ?.?] Out-of-bounds read at 0x???? (32B right of kfence-#???):
	 [    ?.?]  test_out_of_bounds_read.cold+0x????/0x????
	 [    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 [    ?.?]  ret_from_fork_asm+0x????/0x????
	=20
	 [    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	=20
	-[    ?.?] allocated by task 281 on cpu 6 at ?.?s (?.?s ago):
	+[    ?.?] allocated by task 286 on cpu 11 at ?.?s (?.?s ago):
	 --
	 [    ?.?]     # test_out_of_bounds_read-memcache: test_alloc: size=3D32, =
gfp=3Dcc0, policy=3Dleft, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0x?=
???/0x????
	 -
	 :[    ?.?] Out-of-bounds read at 0x???? (1B left of kfence-#???):
	 -[    ?.?]  test_out_of_bounds_read+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 284 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 289 on cpu 8 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_out_of_bounds_read-memcache: test_alloc: size=3D32,=
 gfp=3Dcc0, policy=3Dright, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read.col=
d+0x????/0x????
	 -
	 :[    ?.?] Out-of-bounds read at 0x???? (32B right of kfence-#???):
	 -[    ?.?]  test_out_of_bounds_read.cold+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 284 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 289 on cpu 8 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_out_of_bounds_write: test_alloc: size=3D32, gfp=3Dc=
c0, policy=3Dleft, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: out-of-bounds write in test_out_of_bounds_write+0=
x????/0x????
	 -
	 :[    ?.?] Out-of-bounds write at 0x???? (1B left of kfence-#???):
	 -[    ?.?]  test_out_of_bounds_write+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 288 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 291 on cpu 6 at ?.?s (?.?s ago):
	 --
	--[    ?.?]     # test_out_of_bounds_write-memcache: test_alloc: size=3D32=
, gfp=3Dcc0, policy=3Dleft, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	+-[    ?.?] clocksource: tsc: mask: 0x???? max_cycles: 0x????, max_idle_ns=
: 881590599626 ns
	 :[    ?.?] BUG: KFENCE: out-of-bounds write in test_out_of_bounds_write+0=
x????/0x????
	 -
	 :[    ?.?] Out-of-bounds write at 0x???? (1B left of kfence-#???):
	 -[    ?.?]  test_out_of_bounds_write+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 290 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 293 on cpu 10 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_use_after_free_read: test_alloc: size=3D32, gfp=3Dc=
c0, policy=3Dany, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: use-after-free read in test_use_after_free_read+0=
x????/0x????
	 -
	 :[    ?.?] Use-after-free read at 0x???? (in kfence-#???):
	 -[    ?.?]  test_use_after_free_read+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 292 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 296 on cpu 10 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_use_after_free_read-memcache: test_alloc: size=3D32=
, gfp=3Dcc0, policy=3Dany, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: use-after-free read in test_use_after_free_read+0=
x????/0x????
	 -
	 :[    ?.?] Use-after-free read at 0x???? (in kfence-#???):
	 -[    ?.?]  test_use_after_free_read+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 294 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 298 on cpu 10 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_double_free: test_alloc: size=3D32, gfp=3Dcc0, poli=
cy=3Dany, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: invalid free in test_double_free+0x????/0x????
	 -
	 :[    ?.?] Invalid free of 0x???? (in kfence-#???):
	 -[    ?.?]  test_double_free+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 300 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 304 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_double_free-memcache: test_alloc: size=3D32, gfp=3D=
cc0, policy=3Dany, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: invalid free in test_double_free+0x????/0x????
	 -
	 :[    ?.?] Invalid free of 0x???? (in kfence-#???):
	 -[    ?.?]  test_double_free+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 302 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 306 on cpu 8 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_invalid_addr_free: test_alloc: size=3D32, gfp=3Dcc0=
, policy=3Dany, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: invalid free in test_invalid_addr_free+0x????/0x?=
???
	 -
	 :[    ?.?] Invalid free of 0x???? (in kfence-#???):
	 -[    ?.?]  test_invalid_addr_free+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 304 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 308 on cpu 8 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_invalid_addr_free-memcache: test_alloc: size=3D32, =
gfp=3Dcc0, policy=3Dany, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: invalid free in test_invalid_addr_free+0x????/0x?=
???
	 -
	 :[    ?.?] Invalid free of 0x???? (in kfence-#???):
	 -[    ?.?]  test_invalid_addr_free+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 306 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 310 on cpu 8 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_corruption: test_alloc: size=3D32, gfp=3Dcc0, polic=
y=3Dleft, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: memory corruption in test_corruption+0x????/0x????
	 -
	 :[    ?.?] Corrupted memory at 0x???? [ ! . . . . . . . . . . . . . . . ]=
 (in kfence-#???):
	 -[    ?.?]  test_corruption+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 308 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 312 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_corruption: test_alloc: size=3D32, gfp=3Dcc0, polic=
y=3Dright, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: memory corruption in test_corruption+0x????/0x????
	 -
	 :[    ?.?] Corrupted memory at 0x???? [ ! ] (in kfence-#???):
	 -[    ?.?]  test_corruption+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 308 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 312 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_corruption-memcache: test_alloc: size=3D32, gfp=3Dc=
c0, policy=3Dleft, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: memory corruption in test_corruption+0x????/0x????
	 -
	 :[    ?.?] Corrupted memory at 0x???? [ ! . . . . . . . . . . . . . . . ]=
 (in kfence-#???):
	 -[    ?.?]  test_corruption+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 310 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 314 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_corruption-memcache: test_alloc: size=3D32, gfp=3Dc=
c0, policy=3Dright, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: memory corruption in test_corruption+0x????/0x????
	 -
	 :[    ?.?] Corrupted memory at 0x???? [ ! ] (in kfence-#???):
	 -[    ?.?]  test_corruption+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 310 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 314 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_kmalloc_aligned_oob_read: test_alloc: size=3D73, gf=
p=3Dcc0, policy=3Dright, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: out-of-bounds read in test_kmalloc_aligned_oob_re=
ad+0x????/0x????
	 -
	 :[    ?.?] Out-of-bounds read at 0x???? (105B right of kfence-#???):
	 -[    ?.?]  test_kmalloc_aligned_oob_read+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D73, cache=3Dkmalloc-96
	 -
	--[    ?.?] allocated by task 320 on cpu 10 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 326 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_kmalloc_aligned_oob_write: test_alloc: size=3D73, g=
fp=3Dcc0, policy=3Dright, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: memory corruption in test_kmalloc_aligned_oob_wri=
te+0x????/0x????
	 -
	 :[    ?.?] Corrupted memory at 0x???? [ ! . . . . . . . . . . . . . . . ]=
 (in kfence-#???):
	 -[    ?.?]  test_kmalloc_aligned_oob_write+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D73, cache=3Dkmalloc-96
	 -
	--[    ?.?] allocated by task 326 on cpu 8 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 328 on cpu 4 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     ok 22 test_memcache_ctor
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: invalid read in test_invalid_access+0x????/0x????
	 -
	 -[    ?.?] Invalid read at 0x????:
	 --
	 -[    ?.?]     # test_memcache_typesafe_by_rcu: test_alloc: size=3D32, gf=
p=3Dcc0, policy=3Dany, cache=3D1
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: use-after-free read in test_memcache_typesafe_by_=
rcu.cold+0x????/0x????
	 -
	 :[    ?.?] Use-after-free read at 0x???? (in kfence-#???):
	 -[    ?.?]  test_memcache_typesafe_by_rcu.cold+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dtest
	 -
	--[    ?.?] allocated by task 336 on cpu 6 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 338 on cpu 10 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_krealloc: test_alloc: size=3D32, gfp=3Dcc0, policy=
=3Dany, cache=3D0
	 -[    ?.?] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 :[    ?.?] BUG: KFENCE: use-after-free read in test_krealloc+0x????/0x????
	 -
	 :[    ?.?] Use-after-free read at 0x???? (in kfence-#???):
	 -[    ?.?]  test_krealloc+0x????/0x????
	 -[    ?.?]  kunit_try_run_case+0x????/0x????
	 --
	 -[    ?.?]  ret_from_fork_asm+0x????/0x????
	 -
	 :[    ?.?] kfence-#???: 0x????-0x????, size=3D32, cache=3Dkmalloc-32
	 -
	--[    ?.?] allocated by task 338 on cpu 4 at ?.?s (?.?s ago):
	+-[    ?.?] allocated by task 340 on cpu 6 at ?.?s (?.?s ago):
	 --
	 -[    ?.?]     # test_memcache_alloc_bulk: setup_test_cache: size=3D32, c=
tor=3D0x????
	 -[    ?.?]     ok 27 test_memcache_alloc_bulk
	 :[    ?.?] # kfence: pass:25 fail:0 skip:2 total:27
	 -[    ?.?] # Totals: pass:25 fail:0 skip:2 total:27
	 :[    ?.?] ok 8 kfence
	 -[    ?.?]     KTAP version 1
	 -[    ?.?]     # Subtest: damon

If you'd like me to grep for something more specific, please let me
know.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--v74lbtuwitce4ome
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhsM78ACgkQ64mZXMKQ
wqkNcw//cAOxiIsGa8kbXMBkXN7Ook5P9u2Zs0cUjCYoHn9AIRtW+hYf1lDdnNav
BahwpujFq2zGzRyI1s959gqIYMg6K4bcKTE4INHACBnjgjMpRlHJy80VmHF2teO0
wRIrPP+kH8fp005+LI5DjXLKwT6f8y6n0qGCfvQ9TRXkzrUSs8k0RKnhfW36sSff
OVOARSwCyWLTgW0fXraBYwON/iFLjqYaMtqQrJ98XD1kzuOd8mIySqvFeDT7rZIN
ysSww7O/EkPOGx6eWNpFHdhsW97XfYMsfMjULq3bJ2k6qxEryGG3f2Tz02d3VtYN
Li7+VnK17YTfCtUIvztGRuhXWibtoqEcHt2bkmw1pHU2CTErtQi0c5+eeQ3T67dU
1ypdyvk0q9xBxr77E031Po0VyXtRIhkEFwtAKsLU2zL7ebF9m0kj1tMqYGeS6UfO
8G7ljq4NsBLX75+50dJGzbeRYdcxrMmbCNgAijuH5tN834b4BY5lw2mAuMeYUKg0
58N4TGr/2jZ224zRFArUB7rlnfqnDUs/G4Qb6qM2VQJ0m5viWQ5QEJRvYQSr6TDh
HYvlfve6M4tKrCmCKq6bc5Mpv13I3oGzushJn7gb8dFGkbTBe44youIcBMojljcz
QJWkCtjVuSEA9icPljo1VU9boyGgmnPnf7gznVm1eCmLgpBRbQ0=
=wycf
-----END PGP SIGNATURE-----

--v74lbtuwitce4ome--
