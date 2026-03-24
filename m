Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492893C13FD;
	Tue, 24 Mar 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339298; cv=none; b=CETg+kzYTKVTj/fZHsq8I7aarVI0UK8OWivWRPtTAyi+CjElEV8pETRU81kujfO/wOZ/EtOicMYHtjoZIuGZth6C8PLTFAW19YqhZqxxGS8rETn3q51r3rlHfDAL5vmRobwXwqOTdE7rNBE7pcI4xm6ZpR4OWl2wvPThe2d3Vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339298; c=relaxed/simple;
	bh=L/NRHvWaqdKANbOjHjy0QH5kNVvSd7l1FP/xB0ljk7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpYD0K6uRQBt5KvBmi1u7iOkAFODZIpQPN0iW2IBhBxVPM5wULEBxXSpEDG0dW+7mWVfU2vT2JA6qe5IeQicJkSSARUP0eKYPXLF4vvz7snHrk9yRkMV7DOaSDHo07nZ1yTrJ9b66wNNHmPWuJwG9vkaRrR1ooadkZ0jUREQsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twVeA+g+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twVeA+g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3199C19424;
	Tue, 24 Mar 2026 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774339297;
	bh=L/NRHvWaqdKANbOjHjy0QH5kNVvSd7l1FP/xB0ljk7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twVeA+g+FCSfmvLQzp9g9b630LF57eH2oCJngoiRxlCAqyPAx4hFV1z/AYT5s9/Vc
	 aZ+iBkopqsIt+DJ2aHNZYk3tVn9OF6+8YJ5qq40vGjEkf9TP5m9FArd0xgn5/0RxRg
	 DcW+5z1zxrpZyLwkMsvBT0kd1RS9OkyaJvi3tL1RXUxoT+FVMcfFWYsmR6WQSVz8gF
	 nDqeAnkTEjeA4O4Zg3XqNk/+lJywyHg2AJNP/bpECNSYp8oi0j944FqUWjR4ujiJRz
	 l3Lu1S0RLu186h8pucaL8KTp6xL7diavxy2g97z/y/C150G66RSAVOonlQsgwKwwR/
	 9QxuH0AEtKRZw==
Date: Tue, 24 Mar 2026 01:01:37 -0700
From: Kees Cook <kees@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ACPICA: Replace strncpy() with strscpy_pad() in
 acpi_ut_safe_strncpy()
Message-ID: <202603240100.E64786C688@keescook>
References: <20260323172451.work.079-kees@kernel.org>
 <CAJZ5v0hOS7j2f-wkmvarULCS-1+Zio2hOz2ExMvFXN61OPv_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hOS7j2f-wkmvarULCS-1+Zio2hOz2ExMvFXN61OPv_tQ@mail.gmail.com>

On Mon, Mar 23, 2026 at 06:31:20PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 23, 2026 at 6:24 PM Kees Cook <kees@kernel.org> wrote:
> > [...]
> > kernel APIs before like ACPI_FLEX_ARRAY and similar helpers. However,
> > acpi_ut_safe_strncpy() is an explicit function implementation rather
> > than a macro mapping, so the approach for upstreaming this change to
> > ACPICA is not clear. What's the best way to land this?
> 
> I can apply this directly, it shouldn't be a major problem for porting
> patches from the upstream.

Okay, thanks! I wasn't sure if that was going to be a viable approach.
:)

-Kees

-- 
Kees Cook
