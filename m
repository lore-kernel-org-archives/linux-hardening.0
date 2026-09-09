Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29325F99F;
	Wed,  9 Sep 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939985; cv=none; b=unPjbrVZpgl/ukjUGPbuCYyaxvJkX1bXgQOuP5bavdZm0dOc5OasixUNEWYV4PpQQOfcJ7imgrCs7+LdBjzL7ydQwXfLXhWf/00ReN7Y5NkK/Pua7R+Q+/AG9su6JCbX5+zlyVjwfyoknJUAstGgS3JfEcBCtU+7VFdlYY8dRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939985; c=relaxed/simple;
	bh=8+DQOmtJYZx/yS4aLqQ5/JqJVJptFIvKArI/32tgYA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0UALjIo+J0mB8y9l9+g1ecWEH037hSrQo8I2Ol8hjVoz3EXF75Usf8XqyW4xykz6voUmF+njmjHC8YvAKEyQWvk9Vgv7PETXbQcP4m+E+HYF/kBh41AUcUBklRpPOfBUqVpOiv1yVxSf/urbk7ccK7BqahbaEW5ewExxF5N/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuEyznG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuEyznG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDE01F00A3A;
	Wed,  9 Sep 2026 07:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939984;
	bh=un5ps1LXN7VYcaa1H033LR3Ds9PxcSRKTwukOxcljiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZuEyznG6fSqfCOABFU5OPaGqj+BCXfaZz5gKrVQCs+oyYcGUlHv/IQuL8EJy++hUB
	 RySoLNzgC8WR/r1WVtNcHXWmXc6T3qbBXLYkYe1V+WslIVT1Rm9U+rWmyKCRIZKtXP
	 ugvC5Br2uiqMKtL0gDdUeWYHbdlkm+gLsCuavksdvZFV7J3fM3fD1aHjUMGrJ4jH5X
	 kRTWzGZy5obaox9qb+SEBc2dP2JkQGNgJQ2azg7+RxLqp+WGNTYOWvwKmT7MDXe3tD
	 KE5IBS+dvm5YaXTS3CDOpYNuxJ+BFmjqGht6nKUFZ+UqDVtWwOezI5YcVEULn2fgll
	 Ee0cNJT8ZUIFw==
From: Christian Brauner <brauner@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	codemender-patching+linux@google.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 1/2] userns: Add __counted_by_ptr attribute to struct uid_gid_map
Date: Wed,  9 Sep 2026 09:46:12 +0200
Message-ID: <20260909-tanzmusik-obwohl-einlegen-d10f1e000df0@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908222734.3048684-1-morbo@google.com>
References: <20260908222734.3048684-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=brauner@kernel.org; h=from:subject:message-id; bh=8+DQOmtJYZx/yS4aLqQ5/JqJVJptFIvKArI/32tgYA4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQt5DsxwVpyybxVi8umMTRcuiSc6jRx3yS9suMvZwref H9F2T+wtqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiK1sYGTbsTe/f05ZS3Wuy 4aFc9zqRKtWmF+lVe+8uOZ1sMinBzZeRYaNE3bd38Wf6J0UGXSn+rTuxJvCSjaf5qrySjrn/uOY k8gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 22:27:29 +0000, Bill Wendling wrote:
> The compiler attribute __counted_by_ptr associates a pointer field of a
> struct with a sibling field within the same struct that specifies the
> element count of the allocated memory. This enables KASAN and fortified
> bounds-checking to detect out-of-bounds accesses to the pointer field at
> runtime.
> 
> We can add the __counted_by_ptr attribute to the 'forward' and 'reverse'
> pointer fields of 'struct uid_gid_map', which are counted by
> 'nr_extents'. Since 'nr_extents' is defined in a sibling anonymous
> struct inside an anonymous union, the nearest common non-anonymous
> struct level is 'struct uid_gid_map' itself, which is supported by the
> compiler.
> 
> [...]

Applied to the namespace-7.4.misc branch of the vfs/vfs.git tree.
Patches in the namespace-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: namespace-7.4.misc

[1/2] userns: Add __counted_by_ptr attribute to struct uid_gid_map
      https://git.kernel.org/vfs/vfs/c/b31397fe3007
[2/2] userns: Add KUnit test suite for uid_gid_map
      https://git.kernel.org/vfs/vfs/c/f6f1a2496ba5
