Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D689D10F1
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 03:32:45 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311BB0
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 20:32:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso1294552b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 20:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696390363; x=1696995163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5OaR8DthMsUyWl9mFY7CUG1t46HFxwH/NtoS9Paoao=;
        b=CWSjTOLfUidj+/k6i1A3DoOdhE5OhuTRB+68BrImmMhE8U4NkhujiJVYce/8cc9y1O
         QEeS9VfCd4oYzEZRK1CS1ScVMZgqfbQ73ZM7YZ62N7xSe0P4A3sawCZ7ZkNkayOyjnsR
         gqpQSSgeT9NQvaTFIjH/I5set4oM63NUeJzpHa4BTsc0wuadWYBb1Ga99RP/TBrOa5Ae
         nC8KDQ8azkmPl4Uztua02iQIV9WypRSgcpZVbh8/pTeCaKRXCeZDM3HhrnI9Si+AuNIV
         g8cNtrr7HRYpXYh3eqrHA10W619fwbwN1hzpP2+cqd2IrnFk58fNFkHGD905gFbQgB52
         1bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696390363; x=1696995163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5OaR8DthMsUyWl9mFY7CUG1t46HFxwH/NtoS9Paoao=;
        b=R2YjV1FbPX+SVguuPobH7stjw/kYoZG7msnYj0o+rFy7Rio3FE9BJj+Hro495pggaj
         iZKt1yKXYJ6R9s5G3rEkEhXC+BnfCqNt6giGYrp++laiIvDZLNuYGQE3lzDee/qQJa6W
         Dg6ifTbsLmLHWb4fDTW4spwTHx1W4ehoEo28yYxCuhhLs22SZDCGLAzCBvdFPM9Cd05x
         bKZ7m9UGAZ5o9ouKmu6dk/ro5rq62gkO+24zA+L+Jf2WsRcrQuYi9wcDt7OU8lkVlkkn
         YeKmZ4c9DUEGTK5ZwCegP9B6duRfsvpnMl9kHU6Ge1bwL6i8nZQU1tvQA72hxzdnhq7L
         lj1Q==
X-Gm-Message-State: AOJu0YxkyjXzpsfQI/4dLuGmfJ8impMPSNBv8TaTGKziu+haNVyJt1Hw
	mtcNJIkzeIR+6IXv8FVW86b0oQ==
X-Google-Smtp-Source: AGHT+IGGpsEw0e3LTyT8M7WzDJclFEVAubYuk5fb/YO6bOu6xRTDtMULAYA3M1rgQmLE3v3tCyXsrA==
X-Received: by 2002:a05:6a00:a18:b0:690:fe13:1d28 with SMTP id p24-20020a056a000a1800b00690fe131d28mr1249286pfh.33.1696390363246;
        Tue, 03 Oct 2023 20:32:43 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id m16-20020aa79010000000b0069346777241sm2185428pfo.97.2023.10.03.20.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 20:32:43 -0700 (PDT)
Date: Tue, 3 Oct 2023 20:32:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] netem: Annotate struct disttable with __counted_by
Message-ID: <20231003203240.45705fde@hermes.local>
In-Reply-To: <20231003231823.work.684-kees@kernel.org>
References: <20231003231823.work.684-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue,  3 Oct 2023 16:18:23 -0700
Kees Cook <keescook@chromium.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct disttable.
> 
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

PS: size is intended wrong in original code but that is not important.
Should have lined up with table[].
