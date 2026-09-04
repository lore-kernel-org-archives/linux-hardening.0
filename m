Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE996371876;
	Fri,  4 Sep 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565304; cv=none; b=aQyBy5UsVKKHSumno6wkHx6lVQ5wsS4YESctXlzctljlPlSZN4hBfqKwYb8J0H+VLzYT6D6eLqjgLvpHKdsTGBgGVFQTYzO71bjWyDavJUqL18dc5TTlChUHkowdbXgpb5+9ZaUsk+Is5AMAd9jXI8qJh8OXPYKS7oL9+PVuhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565304; c=relaxed/simple;
	bh=8ojUEeh4GBl3hS2E5GLdg4ArR/wjPMKNgBDXF/wMxNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoEZnxgFJi/Fnr2WQdGIIjpZ9nNcg1TUY5VtOwCAZ7UwaofpuTad2Oy7nNvgQjZxg1eiGqB2Jk5bvFWk9NV93H4cYR5wnNln/IrbCrGRXsG/c7i5GPtlaI6RCuVAgv6RxCyx2ALyC1C7+QBl2TyOn2RwDiRj/EiMHZpCnK4geAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpmEPS+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpmEPS+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADC41F00A3D;
	Fri,  4 Sep 2026 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788565303;
	bh=D1ah88EdIwGVXmatU+RuiQ97sryB7E37mpW2wjtmshI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bpmEPS+HJumyXdhQ8yJzsnnVKiwFEKj7YWx5pHX1+Bna7Y74IlHrqrLGk0AeGc3MY
	 gmayjTIu1dY+6p6GwvEPb4BiF+7vwPC2qeeQpDEnpWP7q/6TCRTi685l7BbwxojrSn
	 srjcVba/OYAbgJkkc71ppGbh+7PrDrZX/h5qvs3qS8TPT0vkJjFUN4TXiPaDeXwB53
	 fhwtgrhPjumJmstigujj5E+Am2ID4ISnTmXYDypVmXdL6Qdi3rFCcEnX2JpEkxW8Q7
	 5qOTvMVn0iUQ+apJKflNHOSnfQ8g7vAGPqJXRbNAdL/jYIu4S48rQIy2odnANHGxqT
	 jy1TaI8tlA2ig==
Date: Fri, 4 Sep 2026 16:41:43 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Bradley Morgan <brads@mainlining.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	codemender-patching+linux@google.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 2/2] userns: Add KUnit test suite for uid_gid_map
Message-ID: <202609041634.6429DB8@keescook>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260826220041.4075333-1-morbo@google.com>
 <20260826220041.4075333-2-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826220041.4075333-2-morbo@google.com>

On Wed, Aug 26, 2026 at 10:00:35PM +0000, Bill Wendling wrote:
> Add a KUnit test suite to verify the insertion and sorting of mappings
> in struct uid_gid_map. This test suite validates both base extent
> insertion (<= 5 mappings) and extended extent insertion (> 5 mappings,
> which triggers the allocation of the forward and reverse pointers).
> 
> This is especially useful for verifying that the __counted_by_ptr
> attribute added to 'forward' and 'reverse' pointers works correctly
> without causing any runtime bounds-checking panics or traps.
> 
> Assisted-by: Gemini:3.1-pro-preview
> Signed-off-by: Bill Wendling <morbo@google.com>

Various style nit-picks as dictated by
Documentation/dev-tools/kunit/style.rst

(We may need to teach Sashiko about KUnit style?)

> kernel/user_namespace_kunit.c | 92 +++++++++++++++++++++++++++++++++++

Like below's naming, this should be named after the suite, and in the
tests/ subdir (even when #included), so it should be:
kernel/tests/user_ns_map_kunit.c

> +config USER_NAMESPACE_KUNIT_TEST

The suite and Kconfig should match, so this should be
USER_NS_MAP_KUNIT_TEST

> +	bool "Test user namespace map insertion" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y
> +	default KUNIT_ALL_TESTS

I think you need a "depends on USER_NS" ?

> +static struct kunit_suite user_ns_map_test_suite = {
> +	.name = "user_ns_map",
> +	.test_cases = user_ns_map_test_cases,
> +};


-Kees

-- 
Kees Cook
