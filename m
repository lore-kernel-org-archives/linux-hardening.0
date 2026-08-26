Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215839021A
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776641; cv=pass; b=b3XkOjCIf65rSv08Y9iegi94LvFWKNu7drclY36fP899vLRuRhuv+8O8Z2EWg5eck+fpt2NIU51VyqnNtfRHGwer9vlWt9nVggeOJUG5NfYBxJdzxqUU37sapFIxDT7cQZ5tNMY50L413Ji5PZiw+qxzNpWa7LKfwBeQXUH5LEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776641; c=relaxed/simple;
	bh=zGDCPZAr8rIObhQUZ6eIXhwp3IZGO3y+WOrn01qU5BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUQ2f5CNHAtHrcChuKO7Km4f+Q9ZusGIWcwn3AcH+gWEsJWiVbOqRNjl43tIKkstD2Cc8kLocSn6t9OwF8R+Lei8TPbavc5RPQQ1Cx0khR6Pp/mv/+OTN+oeZnHVN0P8D4BRZrs6XW2kc1Emj675VPivG2MUA9m4fu42dG9XcvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BC930g/R; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BC930g/R"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97cc700fcf5so235017241.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 13:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787776639; cv=none;
        d=google.com; s=arc-20260327;
        b=Cl6LAy5As/9OdndFZ/495MoICJrL8IJXy7lV++rqOuaKH+l+SGxyRPtFdlyIWuJSVn
         4Xe9DfBciHsckerlT7PoZFhREpmjA99pxMuSmgLpFfUWjL2QvItW8zemWYuB+ZoYJvwf
         zdU5KT21NC4svAhcSmkWR8yydq2ApxdlNWuwGLUzbBFp03vgBV+9Tq+s/fyudFTgraZX
         iXsE0eW0mpdq/mUcGDMvqz4LlUEv3yvCBX0/UHe3mTFA1+OGfB/7I/2AcDiiQEp1Tcyp
         gBkJ6KnQ1LyfKy8vu+UmmBgNciUvgNNCSav5KbNlfbY9SVwIBHcSIcf+XFEhk55RqODn
         O1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHNWMVjvIwfjCOhWDbjhiGpUoUnFKyqrLr/E6gLJdRE=;
        fh=KPLFkDcHySjNoOJzWjub6sd/5Vno5fawwXdgEE1dVqw=;
        b=lYIH2q9U+A3GCNBvTE6U/3fPnPYfozphXVVI08xbXzQLTsfFstIhojCm18xQ94IwgL
         nwHDeSQBB6L1CF2iWJwfb8K+HuhWwdcqJNAKK+hCqGNkgbTav1UfG1KRFjC5Wt/JyGSg
         RbY5C5skP6MkVoW++zQkDxOVcWNHV2Iiy4lie70vhDf6lvVT063Pw6QDWVZYmCyNNIcf
         W81TfL/5Lhtw9UkwjaAO7BE+5cGOW4Nr0DWbpJTLA6op24uPuXZ1kB9DiEO/XbxFlxse
         Zyiu4oUwktiyYO7okwDgtTiu+t3R6QvrjHvIHSlwMJ2eVF93ExIEwfxnbiXW0HJuA49f
         LCiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776639; x=1788381439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHNWMVjvIwfjCOhWDbjhiGpUoUnFKyqrLr/E6gLJdRE=;
        b=BC930g/R8F8+FYfuh3XSluLUbmbCkt5MQhqsy8ecRhbEAVEHKY4MXXe5OFpxYc6lOX
         RBnK07y0hvXuYST3nEQ78cBKwjwuLy0yFV0pQYFp5FnL00hCuZadDtKyiyy/G+79S3gc
         WH9Cm6xqvnrK7PRe+lDc7z/LMWUMR0jBW+SgZtzbgimtmzTWrSfl0ItHXVF56XDC4yT7
         Nxu9qzDgmw34YvfYwPvmFWG4MPdlp07vGGzZE1oo4UiHD40w4GbDBtr6Pfun5ImvJXhl
         WRmUuiQm3DYxfSWUtKohwaXSrawaDLrLT/iYQdfk59+ZYa+ET2iZ2+AQQb8uWvzUledL
         5o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776639; x=1788381439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHNWMVjvIwfjCOhWDbjhiGpUoUnFKyqrLr/E6gLJdRE=;
        b=dNuC8Fy9pOuOwBLnFK2J7Uy+GeZK7jONtXT77795ojFR4urUmt3Ml5iTY00oI/xOIS
         f4+oent3nunZalux1qoU8U9d192SPu9i9806wT0QgT+c/yjd1Cs4Zi8C+9gNJc5MXhIE
         tFswo/P0wbyXovDQo9xBx8/v0ONjP2iqBGfE+waRjrwwOtlf4znGnrIw/kdgbDlwNB9O
         mF6JRwd4+VzqAKIPqhbRa4NLaNgLyl/RGeOXhdTntfQ4VB+04z2lqeh+s49/Sn9ZuAX8
         ZdZ+6qqFN0P1FgV5f8GOGlcdxIyefSwbxxeumeCiaSvlLY3H0ikbXEeljUOnYpP27mAd
         qotA==
X-Forwarded-Encrypted: i=1; AHgh+RqUC6VEb1EcdTuYKFrjnXvZ6xPz3fDUqqWuPeWEzFM0QQJ6gUZXwDhhOCxY5e9HGag/VLCQglGVQ8LBMssTEcg=@vger.kernel.org
X-Gm-Message-State: AFuF++kht4UIV5tcCzBC5SSX6GvoxaN+UsOpj7Dm6iKgnTyzTD6jAn4A
	/8ZALQhwodVjdGYcXrWT+O1ec6tC+uaQv0Vw7ieM+Cw5M4lt5TjWDELR4NRWb7XK+qRMpRPJ6Gi
	kPxejPD7RCe4JFRH/y5D8q6lVwwuNllP9tnfcVzA=
X-Gm-Gg: AR+sD104VKqZFI4Iya4K0nUvqqv91aWPN84n7F02JwqS6pF/EoevF3r/tM59DcqnWxM
	pLA9XMvNXDRQv5WxFMGNmyTDz/Ix5qE+9hjGW1eoo0SUOcJQ7gaDCp8DJssW55CzyRI9wnYoTw+
	yLZ7DTtP88pmdpTLP2LqJuFt6zLQElhGEFjArvH8R8SNkVuBSNfsPAc0HDjoAJcZS1FDVCrVOID
	VPrvs2B9/yugkzAfelXX0q5hwe2CvYRgQfUYdxTkQQWUZ85nARQgZguUyJ9t6m5ibDNIFBHvtI/
	hGmNKONR2HiZZUdceaqEaXFn2zGBV/GNEzKJhsUNasr0cGaWoTLUxiM2oBhupXFvTRdiZUtEPyN
	4w8eejTzJdVD3kFt4D5JD/Gjwz64RK+BDgIIsCsTHWw==
X-Received: by 2002:a05:6102:4189:b0:781:1ac:8242 with SMTP id
 ada2fe7eead31-7841e499c4amr399338137.7.1787776638614; Wed, 26 Aug 2026
 13:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-3-morbo@google.com> <F22B12C6-D4C2-4A7D-8C81-B5FF6443DDF0@grrlz.net>
In-Reply-To: <F22B12C6-D4C2-4A7D-8C81-B5FF6443DDF0@grrlz.net>
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Aug 2026 13:37:01 -0700
X-Gm-Features: AcwNN1U2GfMiyaQAStNs4u0GCHfGLBgKVLjjqzt3ZTdw2vtbVUFLjQn8h9N2Kws
Message-ID: <CAGG=3QXeUoxFqHO=Cs726tyubfeG5+0SdGfrbNJ7svDyejid4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
To: Bradley Morgan <include@grrlz.net>
Cc: aliceryhl@google.com, brauner@kernel.org, 
	codemender-patching+linux@google.com, cyphar@cyphar.com, 
	dianders@chromium.org, gary@garyguo.net, gustavoars@kernel.org, jack@suse.cz, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux.amoon@gmail.com, nathan@kernel.org, 
	nsc@kernel.org, ojeda@kernel.org, oleg@redhat.com, tglx@kernel.org, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bradley,

On Sun, Aug 23, 2026 at 6:48=E2=80=AFAM Bradley Morgan <include@grrlz.net> =
wrote:
>
> Hi Bill,
>
> > +config USER_NAMESPACE_KUNIT_TEST
> > + tristate "KUnit test for user namespace map insertion" if !KUNIT_ALL_=
TESTS
> > + depends on USER_NS && KUNIT
>
> The test is #include'd into user_namespace.c, which is builtin (USER_NS
> is a bool), so =3Dm here still compiles the suite into vmlinux. With
> KUNIT=3Dm that calls kunit symbols that live in a module, and the link
> fails. Make it bool and depend on KUNIT=3Dy, like EXEC_KUNIT_TEST:
>
>  bool "KUnit test for user namespace map insertion" if !KUNIT_ALL_TESTS
>  depends on USER_NS && KUNIT=3Dy
>
Okay.

> > + /* Verify sorting is correct */
> > + for (i =3D 0; i < map.nr_extents; i++) {
> > +  KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> > +  KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);
> > + }
>
> This doesn't verify any sorting. Every extent was inserted with count
> 5, so the loop passes even if sort_idmaps() did nothing. Either assert
> that forward is ordered by .first and reverse by .lower_first, or drop
> the sorting claim from the changelog.
>
Good call. I added in checking for actual values.

> > + /* Clean up allocations to avoid leaks */
> > + kfree(map.forward);
> > + kfree(map.reverse);
>
> Nice.
>
> No tag, add me into V2, please?
>
Done!

-bw
