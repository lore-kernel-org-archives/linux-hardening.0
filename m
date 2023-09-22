Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E544492
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 18:56:19 +0000 (UTC)
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 11:56:18 PDT
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BAAB;
	Fri, 22 Sep 2023 11:56:18 -0700 (PDT)
Received: from [IPv6:2a00:79e1:abc:12d:b80:57e1:5d19:4ce4] (unknown [104.133.8.100])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A2DC120173;
	Sat, 23 Sep 2023 02:48:13 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1695408500;
	bh=FSxf4hp6EbxHRe+fjQ74d1A0sweRTynwo9c3KieA1cU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YxMJ33g177H3ap8AxEHP+V5EeklnANu+CHfgwzfJFuixJZUoQCGU0fRS0VKta3uL7
	 D25TEv8wO3w50EeMpDzQy4V0EpCJpiHdyfSICwx+RkUoA+EHxiEwEpGCnfTcL44n34
	 PtuhmL+nxByJlHgdu34EMtlbLmWMRM9fjnxQ77Ct5sE09LN/WsvZrSx7bx+/fOu3js
	 8k3lDbWBsZITbCScaI3iqr3o4NKIpmrzSbnM8hAbkTm2im0JU2EyHwKt9aES8bG1dX
	 mZVvR8VVWIR/NWDEraYrOryhrn7So8w4yx7I5Ob/IdeuZNftw7lDqwIbOEBahKvjcs
	 cNzBTfnhrltWw==
Message-ID: <66b317e630f6904cbddbb8affcf06b59b4c0ead8.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: dw: Annotate struct dw_i3c_xfer with __counted_by
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Kees Cook <keescook@chromium.org>, Alexandre Belloni
	 <alexandre.belloni@bootlin.com>
Cc: Joel Stanley <joel@jms.id.au>, linux-i3c@lists.infradead.org, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Tom Rix <trix@redhat.com>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Matt Johnston
 <matt@codeconstruct.com.au>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Jack Chen <zenghuchen@google.com>,
 linux-kernel@vger.kernel.org,  llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Date: Fri, 22 Sep 2023 11:48:11 -0700
In-Reply-To: <20230922175011.work.800-kees@kernel.org>
References: <20230922175011.work.800-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kees,

> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> checking via CONFIG_UBSAN_BOUNDS (for array indexing) and
> CONFIG_FORTIFY_SOURCE (for strcpy/memcpy- family functions).

Nice!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
