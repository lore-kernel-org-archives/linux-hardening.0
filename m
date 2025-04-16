Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FC28373;
	Wed, 16 Apr 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831799; cv=none; b=TY1H1QZND0yNJmbcHV3kQlUzmUrZrIJ+DI+g8eOC3QQ8Ivid6cLho/pBvJhjGtrzqHo+EJHFj1US9kMVDFsYj98iecdzC5OqWOWiRkMOmwffn2+lMSYk8Ar/u2cGYcPlrcNBntz1vrALEI5+JfOrEOycd2/fXLrWYhAqcn0mpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831799; c=relaxed/simple;
	bh=Dp9xsrRHfTCGaPrVBtmOH3bhHIpWaLITX6fhTfah+Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj6jsOHrPmnaNA2hoXdZFiTF0uZKBLP78AQ2N2fc+cuM65W7mIV9a+Z97UP5MLIypkw+lDNma+ZGXbseeF757dAatDgKIaIM9d04nSiQMXDE5ufmbxEwoK3LLPsv8uTLJsFEJJcruWCRHQkhOCtrb5b2bZbx+NNbCJhr7mo/l5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+1sDu4N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+1sDu4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB6FC4CEE2;
	Wed, 16 Apr 2025 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831799;
	bh=Dp9xsrRHfTCGaPrVBtmOH3bhHIpWaLITX6fhTfah+Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+1sDu4NPecnwL4gjR+TbsptTGOygfUtfBgtv5FchhZdt2Mou4+D3iSPBTI12Z+7s
	 VflUkDkA858S9A1NYYa+5kDL9z+DnggybcjRv9GLAgFdQjeRx1OX3S6wKcHrGz+uzT
	 ZxI4zYo10IHQKXVldiAhwAUBFh5lsf9yF/iUVWV4GMiJ1qBZfunjRvNsJFgBD58Ixd
	 5O19+Hj4PpO29tpscRTBR4qXn9C10BeX40iuhLjOATES9ZaslXNA9FWLirWz6uhPif
	 /gNSdMc+75Z32JL4STWAVL62bkUTWK3tdKAZ3f6YSoyNcFjSsyVO9rl5GtUzmPAj6d
	 h8IdZFyd0t/pg==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	llvm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler_types: Identify compiler versions for __builtin_dynamic_object_size
Date: Wed, 16 Apr 2025 12:29:46 -0700
Message-Id: <174483177862.740549.10024436361838890808.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416172016.work.154-kees@kernel.org>
References: <20250416172016.work.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Apr 2025 10:20:20 -0700, Kees Cook wrote:
> Clarify when __builtin_dynamic_object_size() is available. All our
> supported Clang versions support it. GCC 12 and later support it. Link
> to documentation for both.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] compiler_types: Identify compiler versions for __builtin_dynamic_object_size
      https://git.kernel.org/kees/c/833dd6a6a1b1

Take care,

-- 
Kees Cook

