Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7724177F;
	Fri, 22 Sep 2023 21:58:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB37CA;
	Fri, 22 Sep 2023 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=34Jgc2qKDQ7wZQCdQoB+y51xg6Z4aiKgekUDpK+B2q0=; b=xbClNM2ZujAWPSEjhHMFgl7DgQ
	j0dHNcmvLgtvUpx4pPQ/1hPRDD3mx6KZQwcElTzta9vpWqrUJirWpx84mQP55EoXkIMkx7adAPhBo
	Hu4OVyiOj1XpObdJoWnHR/j1ZM9lF/rnkSnWU7u0nRXLW92rgFqgRaEdU9xTzeY6RzP0UJvrAcrgb
	ov46fTdVQ8DjIg8aMVQtUL3w4lJjjcNfOf/6eiSgVYo4/cXp3RZHOikHC8tQyUUlzlsrgk+HfzKFE
	9VsqMBRo7OV6ZDHmGs1uIhT5CS+jELqM+kGDuRrs4Y6MMiPvkVHYM8ZMyXDxPzw+W5OBI/vxBQeio
	ufSgba4g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qjo9s-009sqR-2p;
	Fri, 22 Sep 2023 21:57:56 +0000
Date: Fri, 22 Sep 2023 14:57:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-modules@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] module: Annotate struct module_notes_attrs with
 __counted_by
Message-ID: <ZQ4N5CToM15Nsm+K@bombadil.infradead.org>
References: <20230922175253.work.237-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175253.work.237-kees@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:52:53AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct module_notes_attrs.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, applied and pushed!

  Luis
