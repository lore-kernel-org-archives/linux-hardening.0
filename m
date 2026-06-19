Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60B359A66
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781904991; cv=none; b=C+z3aPSQZDxt4ux9iGfHg4dpipBVRaNNe/20swoflNnCGKsHjs1O8uPbSCRBSQMmSnlV5zP48XqhQlQR7TDZwn7kvW00wqc9Dnne7HxrJ8JlaTQGUZQMyJVwXYHG4YsPpJ9LYclrymwHVV5t6yxJH2Odx2H5C5Cvrye7B+O1Eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781904991; c=relaxed/simple;
	bh=/77CwyNslz0slHAH+ENIsRNva9cblIivJOSNszXZY3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHLVbYFyrc/rdds0/Er+lERHZNvmgFJMRA9sVfY5AqBF3XZEeqA2kC/3cdnA1HQya61uz76BOvGJzl4/pgGml6GUxhsJwlWOVK61EV7KKywwsM1djqs/Z8e5bLgSwxTQ/7zjD6iOA9ZL0GnzzuUxv1f39w9vj63KRfScQRGtVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=YRhubJpP; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="YRhubJpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1781904971;
	bh=u8h3CvBVfBrS5xzL0QBDVjt5gW9QYKEbrSyLarS0v70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YRhubJpPyUzY0icQKMsrg4GQYpFaVSwJXnV9dPpRwd6eJEZ22YtpifnyEvjQ6cvyy
	 2Ok2Jgl419CWZi8dxqEQoEmmjnLUrwjKS5/20Tt4Qm4P7hMAJeeO2rXaJ4SqfxG2nr
	 j+g9xXO02/gW6p8NXE4/JIC/hlsyWIo1K/yScnws=
Received: from vra-170-31.tugraz.at (vra-170-31.tugraz.at [129.27.170.31])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4ghrWH0Lwdz2xL0;
	Fri, 19 Jun 2026 23:36:10 +0200 (CEST)
Message-ID: <c4217b162310997b0a64603219543cc00ffa2227.camel@tugraz.at>
Subject: Re: [PATCH v2] c: handle .ACCESS_WITH_SIZE in build_unary_op for
 !/+/- [PR125604]
From: Martin Uecker <uecker@tugraz.at>
To: Kees Cook <kees@kernel.org>, Joseph Myers <josmyers@redhat.com>
Cc: Richard Biener <rguenther@suse.de>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Date: Fri, 19 Jun 2026 23:36:10 +0200
In-Reply-To: <202606181328.ABB25F969C@keescook>
References: <20260618195646.it.067-kees@kernel.org>
	 <202606181328.ABB25F969C@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Donnerstag, dem 18.06.2026 um 13:29 -0700 schrieb Kees Cook:
> On Thu, Jun 18, 2026 at 12:56:51PM -0700, Kees Cook wrote:
> > Unwrap the .ACCESS_WITH_SIZE call at the top of build_unary_op via
> > get_ref_from_access_with_size.  These unary operators consume the
> > pointer rvalue rather than the pointed-to data, so the bounds-checking
> > wrapper is not load-bearing here.  The assertion is retained: after
> > the unwrap it documents the post-condition the rest of the function
> > relies on.
>=20
> BTW, I don't have commit access, so if this patch looks good, I still
> need someone to commit for me. :)

I committed it.

Martin
