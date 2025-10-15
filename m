Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA02ED16C
	for <linux-hardening@vger.kernel.org>; Wed, 15 Oct 2025 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563305; cv=none; b=IeyXos/zTpgVNz6wr0a/JoSEJbGcjRSuBHYBfsf7Pog6m2XdNJLOyOmBcj+/sPlckavcNAnllX3GZHA374JsXzte+p9GFo4rooqHb9pauEwgDgnGsDOZgZr0WzUVvRyMAyt0xZHxnTutXybIRbx+Byu+SstCCdh/RqzZPpNZGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563305; c=relaxed/simple;
	bh=JsC/GhzbH2i1MxLUXiW1NwSGkml6b5OcZ6dA+I1MkI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVVxSbcNB7F3m8ON4j6DvGkv1dgu5oh477Gqz4c2kcPhA0IEcBAXg4FZ+qEdsikxvb+536ClbcTuP2CzulLv8CY+LGn7JJ5e6nBhFWqwyoKTQiR6mDoXpds7/TOQRb9E+wH0/pF50l4kl+hHb2lOzqjJvNAfgIPmJlRGAJcOHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjOQcI+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjOQcI+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5D9C4CEF8;
	Wed, 15 Oct 2025 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760563305;
	bh=JsC/GhzbH2i1MxLUXiW1NwSGkml6b5OcZ6dA+I1MkI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjOQcI+GMdY5Bahtzrd6CYu0YJOT5jZxZqS6QjMUJ2bQqCn8WoazdItRibdIQ8Pl7
	 79hdWE16yEKYCS2EbqckaTcrfzxJVgFciiYCESwsBQCT3lU1OQP2OAwci7vQj961O7
	 Eeh9bSChewIxn0O3c1QuZAYaTPbxKUqGQOosuDVHRu85m6m/hLSt1bMgsNnn4V5G2+
	 d7tcv9Kbsr6gXQFsL0GIsSOBm1HyYnJ+0iI7EDQNIG6l1ekKYUQ2uXd7nx30snUDju
	 ylPNzq11VHFwjuP4AImRY4h9/3j4ZFqaz86i6uFV8MG5PIwYvosq6Byid6055pRSa8
	 Gwpb+dOe6jApw==
Date: Wed, 15 Oct 2025 14:21:45 -0700
From: Kees Cook <kees@kernel.org>
To: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
Cc: Qing Zhao <qing.zhao@oracle.com>,
	Claudiu Zissulescu <claziss@gmail.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] arc: Add const attribute support for mathematical ARC
 builtins
Message-ID: <202510151421.6E4064C3@keescook>
References: <20250826042212.work.202-kees@kernel.org>
 <D882BBEB-31E0-48A9-A595-BC5B47EE4899@oracle.com>
 <d146466d-e5b6-450d-8b6c-c27ecc87b310@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d146466d-e5b6-450d-8b6c-c27ecc87b310@oracle.com>

On Wed, Oct 15, 2025 at 11:34:38AM +0300, Claudiu Zissulescu wrote:
> Sorry for this delay, my gmail account has marked this patch mail as spam
> and delete it.

It happens! ;)

> LGTM, and thank you for your contribution.
> 
> Please let me know if you need my help to apply the patch,

Thanks! I don't have commit access, so if either you or Qing could
commit, that would be lovely. :)

-Kees

-- 
Kees Cook
