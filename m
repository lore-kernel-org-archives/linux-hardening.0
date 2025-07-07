Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF719D89B;
	Mon,  7 Jul 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899183; cv=none; b=PaKFQVGMmiMnRbX9AjK1AA7AYIetYJFqRIi6/mRB8KexB5S+WtYEssDl7tTC0DA6svg/Y+rUE5ekgBpGcyePZXCu4hYSYGQbStDx/R0OCKfTcvd0qzJkPvP1fW5sSGntu0yUxYnXifenC2Pj6LSXmTz0ZIcUHtv0vUCFEuFcrDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899183; c=relaxed/simple;
	bh=z1Latl8loDOWOmzx/9iRCOom6xqSToKmS11KlUnlM44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZfrUWvok+kDtJ9Q6k68t6how3yQTe7Y36VQGryRgl+xTMjz9prlzPu6tliQYtNsR9mBrldrq7cLnT/Bw//CWvPSfCl1FBYDlhYoeuRjsxT4/xyrjyt4I3yQNBmQTd8/l5GzkbfhY4HITQV8DtH72dWGuoUt3r0HkcnRGeDvieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu0gY5q/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu0gY5q/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BB9C4CEE3;
	Mon,  7 Jul 2025 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751899182;
	bh=z1Latl8loDOWOmzx/9iRCOom6xqSToKmS11KlUnlM44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu0gY5q/gVGfwQttPVIk3Cqam067R8M+RQfS1r5tmzeajJjxZZKnuDg/0JhXb/1fO
	 sgw6rDuMwII7EYYq6ds/HwJ3Ob0WABbLpHcGYBNwvhN83zA4RZuxC/5wraKjF4dLD8
	 NmARqJuiOShOA77S+69ZiRYp/JgncDxezKoZmlErAsPsu5JjSAACaQCn7UA0uhgd5c
	 69/xofHNSdXPh8xReGyrAj3O/eHLqUi5gEP/D3EAgDd9LZr2UvmN+jpgAh9StbNXmX
	 Sbk2Ju29dXtEg4IWvA820bDZN6uDs3ojpHJFAuRdXSzcbTK1oavAZ0lJRjgQMJSszH
	 YMn+Bbxbhk/cg==
Date: Mon, 7 Jul 2025 16:39:37 +0200
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
Message-ID: <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzndlq26xqhms7za"
Content-Disposition: inline
In-Reply-To: <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>


--pzndlq26xqhms7za
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
MIME-Version: 1.0
In-Reply-To: <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>

Hi Marco,

On Mon, Jul 07, 2025 at 09:44:09AM +0200, Marco Elver wrote:
> On Mon, 7 Jul 2025 at 07:06, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > While doing this, I detected some anomalies in the existing code:
> >
> > mm/kfence/kfence_test.c:
> >
> >         -  The last call to scnprintf() did increment 'cur', but it's
> >            unused after that, so it was dead code.  I've removed the de=
ad
> >            code in this patch.
>=20
> That was done to be consistent with the other code for readability,
> and to be clear where the next bytes should be appended (if someone
> decides to append more). There is no runtime dead code, the compiler
> optimizes away the assignment. But I'm indifferent, so removing the
> assignment is fine if you prefer that.

Yeah, I guessed that might be the reason.  I'm fine restoring it if you
prefer it.  I tend to use -Wunused-but-set-variable, but if it is not
used here and doesn't trigger, I guess it's fine to keep it.

> Did you run the tests? Do they pass?

I don't know how to run them.  I've only built the kernel.  If you point
me to instructions on how to run them, I'll do so.  Thanks!

> >         -  'end' is calculated as
> >
> >                 end =3D &expect[0][sizeof(expect[0] - 1)];
> >
> >            However, the '-1' doesn't seem to be necessary.  When passing
> >            $2 to scnprintf(), the size was specified as 'end - cur'.
> >            And scnprintf() --just like snprintf(3)--, won't write more
> >            than $2 bytes (including the null byte).  That means that
> >            scnprintf() wouldn't write more than
> >
> >                 &expect[0][sizeof(expect[0]) - 1] - expect[0]
> >
> >            which simplifies to
> >
> >                 sizeof(expect[0]) - 1
> >
> >            bytes.  But we have sizeof(expect[0]) bytes available, so
> >            we're wasting one byte entirely.  This is a benign off-by-one
> >            bug.  The two occurrences of this bug will be fixed in a
> >            following patch in this series.
> >
> > mm/kmsan/kmsan_test.c:
> >
> >         The same benign off-by-one bug calculating the remaining size.
>=20
>=20
> Same - does the test pass?

Same; built the kernel, but didn't know how to run tests.


Have a lovely day!
Alex

> > mm/mempolicy.c:
> >
> >         This file uses the 'p +=3D snprintf()' anti-pattern.  That will
> >         overflow the pointer on truncation, which has undefined
> >         behavior.  Using seprintf(), this bug is fixed.
> >
> >         As in the previous file, here there was also dead code in the
> >         last scnprintf() call, by incrementing a pointer that is not
> >         used after the call.  I've removed the dead code.
> >
> > mm/page_owner.c:
> >
> >         Within print_page_owner(), there are some calls to scnprintf(),
> >         which do report truncation.  And then there are other calls to
> >         snprintf(), where we handle errors (there are two 'goto err').
> >
> >         I've kept the existing error handling, as I trust it's there for
> >         a good reason (i.e., we may want to avoid calling
> >         print_page_owner_memcg() if we truncated before).  Please review
> >         if this amount of error handling is the right one, or if we want
> >         to add or remove some.  For seprintf(), a single test for null
> >         after the last call is enough to detect truncation.
> >
> > mm/slub.c:
> >
> >         Again, the 'p +=3D snprintf()' anti-pattern.  This is UB, and by
> >         using seprintf() we've fixed the bug.
> >
> > Fixes: f99e12b21b84 (2021-07-30; "kfence: add function to mask address =
bits")
> > [alx: that commit introduced dead code]
> > Fixes: af649773fb25 (2024-07-17; "mm/numa_balancing: teach mpol_to_str =
about the balancing mode")
> > [alx: that commit added p+=3Dsnprintf() calls, which are UB]
> > Fixes: 2291990ab36b (2008-04-28; "mempolicy: clean-up mpol-to-str() mem=
policy formatting")
> > [alx: that commit changed p+=3Dsprintf() into p+=3Dsnprintf(), which is=
 still UB]
> > Fixes: 948927ee9e4f (2013-11-13; "mm, mempolicy: make mpol_to_str robus=
t and always succeed")
> > [alx: that commit changes old code into p+=3Dsnprintf(), which is still=
 UB]
> > [alx: that commit also produced dead code by leaving the last 'p+=3D...=
']
> > Fixes: d65360f22406 (2022-09-26; "mm/slub: clean up create_unique_id()")
> > [alx: that commit changed p+=3Dsprintf() into p+=3Dsnprintf(), which is=
 still UB]
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Chao Yu <chao.yu@oppo.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >  mm/kfence/kfence_test.c | 24 ++++++++++++------------
> >  mm/kmsan/kmsan_test.c   |  4 ++--
> >  mm/mempolicy.c          | 18 +++++++++---------
> >  mm/page_owner.c         | 32 +++++++++++++++++---------------
> >  mm/slub.c               |  5 +++--
> >  5 files changed, 43 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> > index 00034e37bc9f..ff734c514c03 100644
> > --- a/mm/kfence/kfence_test.c
> > +++ b/mm/kfence/kfence_test.c
> > @@ -113,26 +113,26 @@ static bool report_matches(const struct expect_re=
port *r)
> >         end =3D &expect[0][sizeof(expect[0]) - 1];
> >         switch (r->type) {
> >         case KFENCE_ERROR_OOB:
> > -               cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: out-of=
-bounds %s",
> > +               cur =3D seprintf(cur, end, "BUG: KFENCE: out-of-bounds =
%s",
> >                                  get_access_type(r));
> >                 break;
> >         case KFENCE_ERROR_UAF:
> > -               cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: use-af=
ter-free %s",
> > +               cur =3D seprintf(cur, end, "BUG: KFENCE: use-after-free=
 %s",
> >                                  get_access_type(r));
> >                 break;
> >         case KFENCE_ERROR_CORRUPTION:
> > -               cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: memory=
 corruption");
> > +               cur =3D seprintf(cur, end, "BUG: KFENCE: memory corrupt=
ion");
> >                 break;
> >         case KFENCE_ERROR_INVALID:
> > -               cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: invali=
d %s",
> > +               cur =3D seprintf(cur, end, "BUG: KFENCE: invalid %s",
> >                                  get_access_type(r));
> >                 break;
> >         case KFENCE_ERROR_INVALID_FREE:
> > -               cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: invali=
d free");
> > +               cur =3D seprintf(cur, end, "BUG: KFENCE: invalid free");
> >                 break;
> >         }
> >
> > -       scnprintf(cur, end - cur, " in %pS", r->fn);
> > +       seprintf(cur, end, " in %pS", r->fn);
> >         /* The exact offset won't match, remove it; also strip module n=
ame. */
> >         cur =3D strchr(expect[0], '+');
> >         if (cur)
> > @@ -144,26 +144,26 @@ static bool report_matches(const struct expect_re=
port *r)
> >
> >         switch (r->type) {
> >         case KFENCE_ERROR_OOB:
> > -               cur +=3D scnprintf(cur, end - cur, "Out-of-bounds %s at=
", get_access_type(r));
> > +               cur =3D seprintf(cur, end, "Out-of-bounds %s at", get_a=
ccess_type(r));
> >                 addr =3D arch_kfence_test_address(addr);
> >                 break;
> >         case KFENCE_ERROR_UAF:
> > -               cur +=3D scnprintf(cur, end - cur, "Use-after-free %s a=
t", get_access_type(r));
> > +               cur =3D seprintf(cur, end, "Use-after-free %s at", get_=
access_type(r));
> >                 addr =3D arch_kfence_test_address(addr);
> >                 break;
> >         case KFENCE_ERROR_CORRUPTION:
> > -               cur +=3D scnprintf(cur, end - cur, "Corrupted memory at=
");
> > +               cur =3D seprintf(cur, end, "Corrupted memory at");
> >                 break;
> >         case KFENCE_ERROR_INVALID:
> > -               cur +=3D scnprintf(cur, end - cur, "Invalid %s at", get=
_access_type(r));
> > +               cur =3D seprintf(cur, end, "Invalid %s at", get_access_=
type(r));
> >                 addr =3D arch_kfence_test_address(addr);
> >                 break;
> >         case KFENCE_ERROR_INVALID_FREE:
> > -               cur +=3D scnprintf(cur, end - cur, "Invalid free of");
> > +               cur =3D seprintf(cur, end, "Invalid free of");
> >                 break;
> >         }
> >
> > -       cur +=3D scnprintf(cur, end - cur, " 0x%p", (void *)addr);
> > +       seprintf(cur, end, " 0x%p", (void *)addr);
> >
> >         spin_lock_irqsave(&observed.lock, flags);
> >         if (!report_available())
> > diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> > index 9733a22c46c1..a062a46b2d24 100644
> > --- a/mm/kmsan/kmsan_test.c
> > +++ b/mm/kmsan/kmsan_test.c
> > @@ -107,9 +107,9 @@ static bool report_matches(const struct expect_repo=
rt *r)
> >         cur =3D expected_header;
> >         end =3D &expected_header[sizeof(expected_header) - 1];
> >
> > -       cur +=3D scnprintf(cur, end - cur, "BUG: KMSAN: %s", r->error_t=
ype);
> > +       cur =3D seprintf(cur, end, "BUG: KMSAN: %s", r->error_type);
> >
> > -       scnprintf(cur, end - cur, " in %s", r->symbol);
> > +       seprintf(cur, end, " in %s", r->symbol);
> >         /* The exact offset won't match, remove it; also strip module n=
ame. */
> >         cur =3D strchr(expected_header, '+');
> >         if (cur)
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index b28a1e6ae096..c696e4a6f4c2 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3359,6 +3359,7 @@ int mpol_parse_str(char *str, struct mempolicy **=
mpol)
> >  void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
> >  {
> >         char *p =3D buffer;
> > +       char *e =3D buffer + maxlen;
> >         nodemask_t nodes =3D NODE_MASK_NONE;
> >         unsigned short mode =3D MPOL_DEFAULT;
> >         unsigned short flags =3D 0;
> > @@ -3384,33 +3385,32 @@ void mpol_to_str(char *buffer, int maxlen, stru=
ct mempolicy *pol)
> >                 break;
> >         default:
> >                 WARN_ON_ONCE(1);
> > -               snprintf(p, maxlen, "unknown");
> > +               seprintf(p, e, "unknown");
> >                 return;
> >         }
> >
> > -       p +=3D snprintf(p, maxlen, "%s", policy_modes[mode]);
> > +       p =3D seprintf(p, e, "%s", policy_modes[mode]);
> >
> >         if (flags & MPOL_MODE_FLAGS) {
> > -               p +=3D snprintf(p, buffer + maxlen - p, "=3D");
> > +               p =3D seprintf(p, e, "=3D");
> >
> >                 /*
> >                  * Static and relative are mutually exclusive.
> >                  */
> >                 if (flags & MPOL_F_STATIC_NODES)
> > -                       p +=3D snprintf(p, buffer + maxlen - p, "static=
");
> > +                       p =3D seprintf(p, e, "static");
> >                 else if (flags & MPOL_F_RELATIVE_NODES)
> > -                       p +=3D snprintf(p, buffer + maxlen - p, "relati=
ve");
> > +                       p =3D seprintf(p, e, "relative");
> >
> >                 if (flags & MPOL_F_NUMA_BALANCING) {
> >                         if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
> > -                               p +=3D snprintf(p, buffer + maxlen - p,=
 "|");
> > -                       p +=3D snprintf(p, buffer + maxlen - p, "balanc=
ing");
> > +                               p =3D seprintf(p, e, "|");
> > +                       p =3D seprintf(p, e, "balancing");
> >                 }
> >         }
> >
> >         if (!nodes_empty(nodes))
> > -               p +=3D scnprintf(p, buffer + maxlen - p, ":%*pbl",
> > -                              nodemask_pr_args(&nodes));
> > +               seprintf(p, e, ":%*pbl", nodemask_pr_args(&nodes));
> >  }
> >
> >  #ifdef CONFIG_SYSFS
> > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > index cc4a6916eec6..5811738e3320 100644
> > --- a/mm/page_owner.c
> > +++ b/mm/page_owner.c
> > @@ -496,7 +496,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_f=
ile *m,
> >  /*
> >   * Looking for memcg information and print it out
> >   */
> > -static inline int print_page_owner_memcg(char *kbuf, size_t count, int=
 ret,
> > +static inline char *print_page_owner_memcg(char *p, const char end[0],
> >                                          struct page *page)
> >  {
> >  #ifdef CONFIG_MEMCG
> > @@ -511,8 +511,7 @@ static inline int print_page_owner_memcg(char *kbuf=
, size_t count, int ret,
> >                 goto out_unlock;
> >
> >         if (memcg_data & MEMCG_DATA_OBJEXTS)
> > -               ret +=3D scnprintf(kbuf + ret, count - ret,
> > -                               "Slab cache page\n");
> > +               p =3D seprintf(p, end, "Slab cache page\n");
> >
> >         memcg =3D page_memcg_check(page);
> >         if (!memcg)
> > @@ -520,7 +519,7 @@ static inline int print_page_owner_memcg(char *kbuf=
, size_t count, int ret,
> >
> >         online =3D (memcg->css.flags & CSS_ONLINE);
> >         cgroup_name(memcg->css.cgroup, name, sizeof(name));
> > -       ret +=3D scnprintf(kbuf + ret, count - ret,
> > +       p =3D seprintf(p, end,
> >                         "Charged %sto %smemcg %s\n",
> >                         PageMemcgKmem(page) ? "(via objcg) " : "",
> >                         online ? "" : "offline ",
> > @@ -529,7 +528,7 @@ static inline int print_page_owner_memcg(char *kbuf=
, size_t count, int ret,
> >         rcu_read_unlock();
> >  #endif /* CONFIG_MEMCG */
> >
> > -       return ret;
> > +       return p;
> >  }
> >
> >  static ssize_t
> > @@ -538,14 +537,16 @@ print_page_owner(char __user *buf, size_t count, =
unsigned long pfn,
> >                 depot_stack_handle_t handle)
> >  {
> >         int ret, pageblock_mt, page_mt;
> > -       char *kbuf;
> > +       char *kbuf, *p, *e;
> >
> >         count =3D min_t(size_t, count, PAGE_SIZE);
> >         kbuf =3D kmalloc(count, GFP_KERNEL);
> >         if (!kbuf)
> >                 return -ENOMEM;
> >
> > -       ret =3D scnprintf(kbuf, count,
> > +       p =3D kbuf;
> > +       e =3D kbuf + count;
> > +       p =3D seprintf(p, e,
> >                         "Page allocated via order %u, mask %#x(%pGg), p=
id %d, tgid %d (%s), ts %llu ns\n",
> >                         page_owner->order, page_owner->gfp_mask,
> >                         &page_owner->gfp_mask, page_owner->pid,
> > @@ -555,7 +556,7 @@ print_page_owner(char __user *buf, size_t count, un=
signed long pfn,
> >         /* Print information relevant to grouping pages by mobility */
> >         pageblock_mt =3D get_pageblock_migratetype(page);
> >         page_mt  =3D gfp_migratetype(page_owner->gfp_mask);
> > -       ret +=3D scnprintf(kbuf + ret, count - ret,
> > +       p =3D seprintf(p, e,
> >                         "PFN 0x%lx type %s Block %lu type %s Flags %pGp=
\n",
> >                         pfn,
> >                         migratetype_names[page_mt],
> > @@ -563,22 +564,23 @@ print_page_owner(char __user *buf, size_t count, =
unsigned long pfn,
> >                         migratetype_names[pageblock_mt],
> >                         &page->flags);
> >
> > -       ret +=3D stack_depot_snprint(handle, kbuf + ret, count - ret, 0=
);
> > -       if (ret >=3D count)
> > -               goto err;
> > +       p =3D stack_depot_seprint(handle, p, e, 0);
> > +       if (p =3D=3D NULL)
> > +               goto err;  // XXX: Should we remove this error handling?
> >
> >         if (page_owner->last_migrate_reason !=3D -1) {
> > -               ret +=3D scnprintf(kbuf + ret, count - ret,
> > +               p =3D seprintf(p, e,
> >                         "Page has been migrated, last migrate reason: %=
s\n",
> >                         migrate_reason_names[page_owner->last_migrate_r=
eason]);
> >         }
> >
> > -       ret =3D print_page_owner_memcg(kbuf, count, ret, page);
> > +       p =3D print_page_owner_memcg(p, e, page);
> >
> > -       ret +=3D snprintf(kbuf + ret, count - ret, "\n");
> > -       if (ret >=3D count)
> > +       p =3D seprintf(p, e, "\n");
> > +       if (p =3D=3D NULL)
> >                 goto err;
> >
> > +       ret =3D p - kbuf;
> >         if (copy_to_user(buf, kbuf, ret))
> >                 ret =3D -EFAULT;
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index be8b09e09d30..b67c6ca0d0f7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -7451,6 +7451,7 @@ static char *create_unique_id(struct kmem_cache *=
s)
> >  {
> >         char *name =3D kmalloc(ID_STR_LENGTH, GFP_KERNEL);
> >         char *p =3D name;
> > +       char *e =3D name + ID_STR_LENGTH;
> >
> >         if (!name)
> >                 return ERR_PTR(-ENOMEM);
> > @@ -7475,9 +7476,9 @@ static char *create_unique_id(struct kmem_cache *=
s)
> >                 *p++ =3D 'A';
> >         if (p !=3D name + 1)
> >                 *p++ =3D '-';
> > -       p +=3D snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
> > +       p =3D seprintf(p, e, "%07u", s->size);
> >
> > -       if (WARN_ON(p > name + ID_STR_LENGTH - 1)) {
> > +       if (WARN_ON(p =3D=3D NULL)) {
> >                 kfree(name);
> >                 return ERR_PTR(-EINVAL);
> >         }
> > --
> > 2.50.0
> >

--=20
<https://www.alejandro-colomar.es/>

--pzndlq26xqhms7za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhr3CEACgkQ64mZXMKQ
wqk4aA/+Mvv63Bmz7LwbWP8jHRGdodX7lT887AsPc0MIl1gzOpJQDO5mawJIKZ2O
Ezz2CFlK0W3da0JvdHK8QoIoyR/NV0+KxOfyliTUDn21rOMmDqH0Y7qE0i9gCLA3
GIIAD3K2WgQf6HMHpbZsGYQTYsOz8lr1mHmE6QHeaaLvlaux4Sa6DeZPAGG3rU7/
NOZvqadKOlS+oNWkgeENZeINRGNsxbldMLuKd3XfR/WTJg1oLzJiiQgTIO1o/X1F
FjwdbCAQMDOcgp9yBPqfm3XfQgiAUtVBt6sOQks7r9+mTHIE7D6eBaXnDSZf+cry
BzQ85B/ABW5MFYG7f7zp21FS7DLivXyRHI60ZFCT/i+fPOxA+mRUbRgv2A0WlMLY
7dL0+7y6RvV+Q53r7ecH8VaBgxoFUN37KJE6fSR1TRI+H0tizGS5w//HRU+Ahods
cFN+w7/TJb7c+1hOTE86MXp28dXEZ7qsHIwlh67aL4F4LaVtzstmp8RgdKRXwYcO
M5PzWaLgRBsvSK0TavaypccT4+mWlsGEiy5K0CV4hu2bXultKXnbxbFmV3XQ77Dx
sc1FRzM0HVT/FJ95KiqREeqRIVK4+MogvZEadOqidPvio7pob6CLXrKAHJg3valr
WSf7uk/yJC61MlWf7gKEbFzQD4/Nnkgum229f2FHj6es6MtYDzs=
=TrTS
-----END PGP SIGNATURE-----

--pzndlq26xqhms7za--
