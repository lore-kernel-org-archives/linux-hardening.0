Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3890432BD6
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238506; cv=none; b=I8P1Av+gDTdWJJRIhUg/J3Zt75s8nTO93DtYsqC4Gzs/bySrE5zU7bLKeH6LWOQUgv625+QJBBZaNGVmjhBSWriTD0QRNlhlHiEiu2aQ0ZFSQ+Dm+0ZweypgkVxf0N8SCieZbCvoG/LpNC6bN0oqe6Vox4UXAyLP/aroNKF5Iuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238506; c=relaxed/simple;
	bh=DUspM/oNodnMNdfgeoQ+UxAJJLrtHJ+XpmqtQN1AeGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nmohGBQQtI5JdFzRbxRvQIfIA1xS1Phc1oEJmJk60Q2NNtS+lajkPXdsWyX//r+kk6W4V7DjB4rl/cwdyoxyigtPipp81lWtJikYaBtciH0XOuhVWq1zDhtGUeuSZ37Z1pAs99CHb6pv6iNKo8/Hj25/VxVwIbmvahIWvwzrJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rduo5fvP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rduo5fvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790238503;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=E7l+yPnrqsYMPZm7GAD6CpPMTa4JzYl3QRtJjgNueTQ=;
	b=Rduo5fvPL3jZa3Wo6LvyackfgABoCRmmcTfkeRwjtHXdTuIwh6exT1zPBimzBdoMEkICEw
	MdUMl6baSG4wPxDicE5SzSYw2Gq9SGvCNUb/0/LFON2Ci1y+xrhi6brYZ9hr38bEHypI6V
	D8HyBlhVdnKyxstiPd47QLSMFID2PvE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-_CBLju1vNoqiisrblErt8w-1; Thu,
 24 Sep 2026 04:28:19 -0400
X-MC-Unique: _CBLju1vNoqiisrblErt8w-1
X-Mimecast-MFC-AGG-ID: _CBLju1vNoqiisrblErt8w_1790238495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5108B197753D;
	Thu, 24 Sep 2026 08:28:14 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.44.33.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2012C180057E;
	Thu, 24 Sep 2026 08:28:11 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.18.1/8.18.1) with ESMTPS id 68O8S8Ji1889880
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:28:08 +0200
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.18.1/8.18.1/Submit) id 68O8Rgd81889878;
	Thu, 24 Sep 2026 10:27:42 +0200
Date: Thu, 24 Sep 2026 10:27:42 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Juergen Christ <jchrist@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        Jeffrey Law <jefflaw@qti.qualcomm.com>,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Osterlund Sebastian <sebastian.osterlund@intel.com>,
        Constable Scott D <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <arTe_idboRBVfJLY@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20260825235748.i.456-kees@kernel.org>
 <20260825235759.3379064-1-kees@kernel.org>
 <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
 <CALvbMcDRqkVH2gBbX-Ss8d7yM=-w3dunZYXuibp7dDrYbuJH3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvbMcDRqkVH2gBbX-Ss8d7yM=-w3dunZYXuibp7dDrYbuJH3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uge-mw9co34dAW2_smF4oc-5NNJsmihV3h_Y9rhysfw_1790238495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2026 at 08:57:49PM -0700, Andrea Pinski wrote:
> > > +/* Test mangling of basic builtin types.  */
> > > +
> > > +static void
> > > +test_typeinfo_basic_types ()
> > > +{
> > > +  ASSERT_STREQ ("v", kcfi_test_mangle (void_type_node).c_str ());
> > > +  ASSERT_STREQ ("c", kcfi_test_mangle (char_type_node).c_str ());
> > > +  ASSERT_STREQ ("a", kcfi_test_mangle (signed_char_type_node).c_str ());
> > > +  ASSERT_STREQ ("h", kcfi_test_mangle (unsigned_char_type_node).c_str ());
> > > +  ASSERT_STREQ ("s", kcfi_test_mangle (short_integer_type_node).c_str ());
> > > +  ASSERT_STREQ ("t", kcfi_test_mangle (short_unsigned_type_node).c_str ());
> > > +  ASSERT_STREQ ("i", kcfi_test_mangle (integer_type_node).c_str ());
> > > +  ASSERT_STREQ ("j", kcfi_test_mangle (unsigned_type_node).c_str ());
> > > +  ASSERT_STREQ ("l", kcfi_test_mangle (long_integer_type_node).c_str ());
> > > +  ASSERT_STREQ ("m", kcfi_test_mangle (long_unsigned_type_node).c_str ());
> > > +  ASSERT_STREQ ("x", kcfi_test_mangle (long_long_integer_type_node).c_str ());
> > > +  ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
> > > +  ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
> > > +  ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> > > +  ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> >
> > I looked at this on s390x.  We actually change the mangling of long
> > double if we are on a target where long double is 128bit IEEE to a
> > "g".  This causes this self-test to fail.  I suggest to add this patch
> > on top of our patch to fix this:
> >
> > diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> > index b6723fac48da..fab06249ae16 100644
> > --- a/gcc/kcfi-typeinfo.cc
> > +++ b/gcc/kcfi-typeinfo.cc
> > @@ -659,7 +659,14 @@ test_typeinfo_basic_types ()
> >    ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
> >    ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
> >    ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> > +#if defined (__s390x__)
> > +  if (TARGET_LONG_DOUBLE_128)
> > +    ASSERT_STREQ ("g", kcfi_test_mangle (long_double_type_node).c_str ());
> > +  else
> > +    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> > +#else
> >    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> > +#endif
> 
> Maybe we should use out the target hook here instead of hard coding
> the encoding.

Certainly.  Note, the ifdef is just wrong, that is testing the host
architecture, while it actually cares about the target architecture.
So, this would also fail miserably with cross-compilers (both from s390x
to something else, then TARGET_LONG_DOUBLE_128 macro wouldn't often even
exist), or from say x86_64 to s390x.
Also, it isn't really s390x specific, alpha also g or e based on options,
ia64 too, on rs6000 it can be e, g or u9__ieee128, on sparc also g or e.

	Jakub

