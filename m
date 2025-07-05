Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64E189906;
	Sat,  5 Jul 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751752449; cv=none; b=jf7PjJqcpCKC0cI1qTjhv7CuCSPcRNmkLuqpWVJiJRygKzVvJ/+wqzPeU+sgaWDxUu+yZgZTVtT3kJCfP8OoMh0Bgr0rUtFsFo+VqWabFU1nLO//nbPJZCBnBWiM3q5ARIjSH3r415KSud/iBGMH+2Q0Q/uLnaqZ92XxeF8c+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751752449; c=relaxed/simple;
	bh=s/yRBKu6UqcUan3ODZyzQSqwzumftBUBlBaea3zaHwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP6SbK9fWs8kr/LCCZP1AB1Srx6/poQpCIC3/BJpm0ZQwsATVEApi15Jww5Fp7kyhm3kYYjmYlBBQu660ZUjgiFvXCk7gYUFPGfQx3+fgjmRSrs419joKpnsaIHOEo2qWFSbhSdPBzENenmAEPfOe1WQ5KPlPwBlFitfEex/8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXdYW4Qn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXdYW4Qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E33C4CEE7;
	Sat,  5 Jul 2025 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751752449;
	bh=s/yRBKu6UqcUan3ODZyzQSqwzumftBUBlBaea3zaHwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXdYW4Qnu95vJga3qYboCnqtZY6vmfnuKPGpjIFcKzXKGoD7uCfZ0eq6qLLL8gaTH
	 rA34MD36JLD/eTurwbX0qAEL+ZP+8ZH05mGu7K61X+MIXUwhmjoi2Lbo67er8enxJK
	 YhUoA8w76nIZZbU09Z6j8m5NBExjNGYZuEyXfDjGqD8UTLVyO3FB3PflVaiBkc4jlh
	 cs2kqIBNyY/cQgRN18DU2KfcKj3UCzEZ7pjGvSyrKZ7xBGXuRYD2h1RrpF2eqgyuS8
	 b+5G16yxfq7l4ft30CX13Pu8yrZg2TEDRkM/oNGYhVJGfJZ3v6n5uvSvKmWpEfLiu4
	 4oysRZ+fQZyIA==
Date: Sat, 5 Jul 2025 23:54:07 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 3/3] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <iuee5umfb5g5awhqx3ibvvgtsk4ymwdersszrys7yhleu3catc@2ubsmycdsmn3>
References: <cover.1751747518.git.alx@kernel.org>
 <be193e1856aaf40f0e6dc44bb2e22ab0688203af.1751747518.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sxjq76zh675ubdos"
Content-Disposition: inline
In-Reply-To: <be193e1856aaf40f0e6dc44bb2e22ab0688203af.1751747518.git.alx@kernel.org>


--sxjq76zh675ubdos
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 3/3] mm: Use seprintf() instead of less ergonomic APIs
References: <cover.1751747518.git.alx@kernel.org>
 <be193e1856aaf40f0e6dc44bb2e22ab0688203af.1751747518.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <be193e1856aaf40f0e6dc44bb2e22ab0688203af.1751747518.git.alx@kernel.org>

On Sat, Jul 05, 2025 at 10:33:53PM +0200, Alejandro Colomar wrote:
> While doing this, I detected some anomalies in the existing code:
>=20
> mm/kfence/kfence_test.c:
>=20
> 	The last call to scnprintf() did increment 'cur', but it's
> 	unused after that, so it was dead code.  I've removed the dead
> 	code in this patch.
>=20
> mm/mempolicy.c:
>=20
> 	This file uses the 'p +=3D snprintf()' anti-pattern.  That will
> 	overflow the pointer on truncation, which has undefined
> 	behavior.  Using seprintf(), this bug is fixed.
>=20
> 	As in the previous file, here there was also dead code in the
> 	last scnprintf() call, by incrementing a pointer that is not
> 	used after the call.  I've removed the dead code.
>=20
> mm/page_owner.c:
>=20
> 	Within print_page_owner(), there are some calls to scnprintf(),
> 	which do report truncation.  And then there are other calls to

This is a typo; I meant s/do/don't/

> 	snprintf(), where we handle errors (there are two 'goto err').
>=20
> 	I've kept the existing error handling, as I trust it's there for
> 	a good reason (i.e., we may want to avoid calling
> 	print_page_owner_memcg() if we truncated before).  Please review
> 	if this amount of error handling is the right one, or if we want
> 	to add or remove some.  For seprintf(), a single test for null
> 	after the last call is enough to detect truncation.
>=20
> mm/slub.c:
>=20
> 	Again, the 'p +=3D snprintf()' anti-pattern.  This is UB, and by
> 	using seprintf() we've fixed the bug.
>=20
> Cc: Kees Cook <kees@kernel.org>
> Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  mm/kfence/kfence_test.c | 24 ++++++++++++------------
>  mm/kmsan/kmsan_test.c   |  4 ++--
>  mm/mempolicy.c          | 18 +++++++++---------
>  mm/page_owner.c         | 32 +++++++++++++++++---------------
>  mm/slub.c               |  5 +++--
>  5 files changed, 43 insertions(+), 40 deletions(-)
>=20
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 00034e37bc9f..ff734c514c03 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -113,26 +113,26 @@ static bool report_matches(const struct expect_repo=
rt *r)
>  	end =3D &expect[0][sizeof(expect[0]) - 1];
>  	switch (r->type) {
>  	case KFENCE_ERROR_OOB:
> -		cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: out-of-bounds %s",
> +		cur =3D seprintf(cur, end, "BUG: KFENCE: out-of-bounds %s",
>  				 get_access_type(r));
>  		break;
>  	case KFENCE_ERROR_UAF:
> -		cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: use-after-free %s",
> +		cur =3D seprintf(cur, end, "BUG: KFENCE: use-after-free %s",
>  				 get_access_type(r));
>  		break;
>  	case KFENCE_ERROR_CORRUPTION:
> -		cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: memory corruption");
> +		cur =3D seprintf(cur, end, "BUG: KFENCE: memory corruption");
>  		break;
>  	case KFENCE_ERROR_INVALID:
> -		cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: invalid %s",
> +		cur =3D seprintf(cur, end, "BUG: KFENCE: invalid %s",
>  				 get_access_type(r));
>  		break;
>  	case KFENCE_ERROR_INVALID_FREE:
> -		cur +=3D scnprintf(cur, end - cur, "BUG: KFENCE: invalid free");
> +		cur =3D seprintf(cur, end, "BUG: KFENCE: invalid free");
>  		break;
>  	}
> =20
> -	scnprintf(cur, end - cur, " in %pS", r->fn);
> +	seprintf(cur, end, " in %pS", r->fn);
>  	/* The exact offset won't match, remove it; also strip module name. */
>  	cur =3D strchr(expect[0], '+');
>  	if (cur)
> @@ -144,26 +144,26 @@ static bool report_matches(const struct expect_repo=
rt *r)
> =20
>  	switch (r->type) {
>  	case KFENCE_ERROR_OOB:
> -		cur +=3D scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_t=
ype(r));
> +		cur =3D seprintf(cur, end, "Out-of-bounds %s at", get_access_type(r));
>  		addr =3D arch_kfence_test_address(addr);
>  		break;
>  	case KFENCE_ERROR_UAF:
> -		cur +=3D scnprintf(cur, end - cur, "Use-after-free %s at", get_access_=
type(r));
> +		cur =3D seprintf(cur, end, "Use-after-free %s at", get_access_type(r));
>  		addr =3D arch_kfence_test_address(addr);
>  		break;
>  	case KFENCE_ERROR_CORRUPTION:
> -		cur +=3D scnprintf(cur, end - cur, "Corrupted memory at");
> +		cur =3D seprintf(cur, end, "Corrupted memory at");
>  		break;
>  	case KFENCE_ERROR_INVALID:
> -		cur +=3D scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r)=
);
> +		cur =3D seprintf(cur, end, "Invalid %s at", get_access_type(r));
>  		addr =3D arch_kfence_test_address(addr);
>  		break;
>  	case KFENCE_ERROR_INVALID_FREE:
> -		cur +=3D scnprintf(cur, end - cur, "Invalid free of");
> +		cur =3D seprintf(cur, end, "Invalid free of");
>  		break;
>  	}
> =20
> -	cur +=3D scnprintf(cur, end - cur, " 0x%p", (void *)addr);
> +	seprintf(cur, end, " 0x%p", (void *)addr);
> =20
>  	spin_lock_irqsave(&observed.lock, flags);
>  	if (!report_available())
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 9733a22c46c1..a062a46b2d24 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -107,9 +107,9 @@ static bool report_matches(const struct expect_report=
 *r)
>  	cur =3D expected_header;
>  	end =3D &expected_header[sizeof(expected_header) - 1];
> =20
> -	cur +=3D scnprintf(cur, end - cur, "BUG: KMSAN: %s", r->error_type);
> +	cur =3D seprintf(cur, end, "BUG: KMSAN: %s", r->error_type);
> =20
> -	scnprintf(cur, end - cur, " in %s", r->symbol);
> +	seprintf(cur, end, " in %s", r->symbol);
>  	/* The exact offset won't match, remove it; also strip module name. */
>  	cur =3D strchr(expected_header, '+');
>  	if (cur)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b28a1e6ae096..c696e4a6f4c2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3359,6 +3359,7 @@ int mpol_parse_str(char *str, struct mempolicy **mp=
ol)
>  void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  {
>  	char *p =3D buffer;
> +	char *e =3D buffer + maxlen;
>  	nodemask_t nodes =3D NODE_MASK_NONE;
>  	unsigned short mode =3D MPOL_DEFAULT;
>  	unsigned short flags =3D 0;
> @@ -3384,33 +3385,32 @@ void mpol_to_str(char *buffer, int maxlen, struct=
 mempolicy *pol)
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> -		snprintf(p, maxlen, "unknown");
> +		seprintf(p, e, "unknown");
>  		return;
>  	}
> =20
> -	p +=3D snprintf(p, maxlen, "%s", policy_modes[mode]);
> +	p =3D seprintf(p, e, "%s", policy_modes[mode]);
> =20
>  	if (flags & MPOL_MODE_FLAGS) {
> -		p +=3D snprintf(p, buffer + maxlen - p, "=3D");
> +		p =3D seprintf(p, e, "=3D");
> =20
>  		/*
>  		 * Static and relative are mutually exclusive.
>  		 */
>  		if (flags & MPOL_F_STATIC_NODES)
> -			p +=3D snprintf(p, buffer + maxlen - p, "static");
> +			p =3D seprintf(p, e, "static");
>  		else if (flags & MPOL_F_RELATIVE_NODES)
> -			p +=3D snprintf(p, buffer + maxlen - p, "relative");
> +			p =3D seprintf(p, e, "relative");
> =20
>  		if (flags & MPOL_F_NUMA_BALANCING) {
>  			if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
> -				p +=3D snprintf(p, buffer + maxlen - p, "|");
> -			p +=3D snprintf(p, buffer + maxlen - p, "balancing");
> +				p =3D seprintf(p, e, "|");
> +			p =3D seprintf(p, e, "balancing");
>  		}
>  	}
> =20
>  	if (!nodes_empty(nodes))
> -		p +=3D scnprintf(p, buffer + maxlen - p, ":%*pbl",
> -			       nodemask_pr_args(&nodes));
> +		seprintf(p, e, ":%*pbl", nodemask_pr_args(&nodes));
>  }
> =20
>  #ifdef CONFIG_SYSFS
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index cc4a6916eec6..5811738e3320 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -496,7 +496,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_fil=
e *m,
>  /*
>   * Looking for memcg information and print it out
>   */
> -static inline int print_page_owner_memcg(char *kbuf, size_t count, int r=
et,
> +static inline char *print_page_owner_memcg(char *p, const char end[0],
>  					 struct page *page)
>  {
>  #ifdef CONFIG_MEMCG
> @@ -511,8 +511,7 @@ static inline int print_page_owner_memcg(char *kbuf, =
size_t count, int ret,
>  		goto out_unlock;
> =20
>  	if (memcg_data & MEMCG_DATA_OBJEXTS)
> -		ret +=3D scnprintf(kbuf + ret, count - ret,
> -				"Slab cache page\n");
> +		p =3D seprintf(p, end, "Slab cache page\n");
> =20
>  	memcg =3D page_memcg_check(page);
>  	if (!memcg)
> @@ -520,7 +519,7 @@ static inline int print_page_owner_memcg(char *kbuf, =
size_t count, int ret,
> =20
>  	online =3D (memcg->css.flags & CSS_ONLINE);
>  	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> -	ret +=3D scnprintf(kbuf + ret, count - ret,
> +	p =3D seprintf(p, end,
>  			"Charged %sto %smemcg %s\n",
>  			PageMemcgKmem(page) ? "(via objcg) " : "",
>  			online ? "" : "offline ",
> @@ -529,7 +528,7 @@ static inline int print_page_owner_memcg(char *kbuf, =
size_t count, int ret,
>  	rcu_read_unlock();
>  #endif /* CONFIG_MEMCG */
> =20
> -	return ret;
> +	return p;
>  }
> =20
>  static ssize_t
> @@ -538,14 +537,16 @@ print_page_owner(char __user *buf, size_t count, un=
signed long pfn,
>  		depot_stack_handle_t handle)
>  {
>  	int ret, pageblock_mt, page_mt;
> -	char *kbuf;
> +	char *kbuf, *p, *e;
> =20
>  	count =3D min_t(size_t, count, PAGE_SIZE);
>  	kbuf =3D kmalloc(count, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;
> =20
> -	ret =3D scnprintf(kbuf, count,
> +	p =3D kbuf;
> +	e =3D kbuf + count;
> +	p =3D seprintf(p, e,
>  			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), t=
s %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
>  			&page_owner->gfp_mask, page_owner->pid,
> @@ -555,7 +556,7 @@ print_page_owner(char __user *buf, size_t count, unsi=
gned long pfn,
>  	/* Print information relevant to grouping pages by mobility */
>  	pageblock_mt =3D get_pageblock_migratetype(page);
>  	page_mt  =3D gfp_migratetype(page_owner->gfp_mask);
> -	ret +=3D scnprintf(kbuf + ret, count - ret,
> +	p =3D seprintf(p, e,
>  			"PFN 0x%lx type %s Block %lu type %s Flags %pGp\n",
>  			pfn,
>  			migratetype_names[page_mt],
> @@ -563,22 +564,23 @@ print_page_owner(char __user *buf, size_t count, un=
signed long pfn,
>  			migratetype_names[pageblock_mt],
>  			&page->flags);
> =20
> -	ret +=3D stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
> -	if (ret >=3D count)
> -		goto err;
> +	p =3D stack_depot_seprint(handle, p, e, 0);
> +	if (p =3D=3D NULL)
> +		goto err;  // XXX: Should we remove this error handling?
> =20
>  	if (page_owner->last_migrate_reason !=3D -1) {
> -		ret +=3D scnprintf(kbuf + ret, count - ret,
> +		p =3D seprintf(p, e,
>  			"Page has been migrated, last migrate reason: %s\n",
>  			migrate_reason_names[page_owner->last_migrate_reason]);
>  	}
> =20
> -	ret =3D print_page_owner_memcg(kbuf, count, ret, page);
> +	p =3D print_page_owner_memcg(p, e, page);
> =20
> -	ret +=3D snprintf(kbuf + ret, count - ret, "\n");
> -	if (ret >=3D count)
> +	p =3D seprintf(p, e, "\n");
> +	if (p =3D=3D NULL)
>  		goto err;
> =20
> +	ret =3D p - kbuf;
>  	if (copy_to_user(buf, kbuf, ret))
>  		ret =3D -EFAULT;
> =20
> diff --git a/mm/slub.c b/mm/slub.c
> index be8b09e09d30..b67c6ca0d0f7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7451,6 +7451,7 @@ static char *create_unique_id(struct kmem_cache *s)
>  {
>  	char *name =3D kmalloc(ID_STR_LENGTH, GFP_KERNEL);
>  	char *p =3D name;
> +	char *e =3D name + ID_STR_LENGTH;
> =20
>  	if (!name)
>  		return ERR_PTR(-ENOMEM);
> @@ -7475,9 +7476,9 @@ static char *create_unique_id(struct kmem_cache *s)
>  		*p++ =3D 'A';
>  	if (p !=3D name + 1)
>  		*p++ =3D '-';
> -	p +=3D snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
> +	p =3D seprintf(p, e, "%07u", s->size);
> =20
> -	if (WARN_ON(p > name + ID_STR_LENGTH - 1)) {
> +	if (WARN_ON(p =3D=3D NULL)) {
>  		kfree(name);
>  		return ERR_PTR(-EINVAL);
>  	}
> --=20
> 2.50.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--sxjq76zh675ubdos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhpnv4ACgkQ64mZXMKQ
wqk1vg//Vt8t78GPcqFyDdPOtmuNVG3IaCmYiHr+QhI76XyxWTBZJE8MIGoYCrsa
07kxIfpn3/0xcVWyFKMlxoayS+0UcwNaeCNlL1QEbfh4nr860TrqSktol0u65gVF
kkzXqZmas40EA8LKrrpragR2XHS96iO8TCuwL6IT2fCKnivMp+a1q3o1DPdQ0tnt
fYBLP8Cjr8DLTeExyVy7+9wpNMvvv8//bi+voTQo0ohkMb3+WlxgRxnFWcEy+Z+7
/wTAzXx0lgBOBpz1fF4h4vDNOVgcaW7712ytUeFkm2q6phr3wAVkt1nSf9dY5H8p
gIFDblBPekrGY+qe24EUGgETmoyjajmHgsLQu8IfMfg4LBfMQ6bjeH8/Ttvovw0A
QlzXS+dTjXw1bFsY1J6IwjczQS5XYodzAbc9zdCTqwB88CUVZcUYhcS7Ed9+W2kN
egwZlh4L5+yVNTk9WvwJn4pqFFBcLtJpVtDCngc6eMovbVsid5QqDVJbCJ4cA0EQ
NiBsaa7cl53zsVAfzdiIXo7JWmeEjdfvqC5KlW2szEzG2g80Q1jCXLToJcV2/i0K
2XGNCNOoaWAKQh5vxe8y16TSYPOxP+pxz0Sbo7vTZaw7GgwOza285nTN8pMjUbDQ
qYT0dagmewcqtlPaXlol0ybzsfK+5tybzJRKnaXXSjDa8/pLIm0=
=krbL
-----END PGP SIGNATURE-----

--sxjq76zh675ubdos--
