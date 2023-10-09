Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDD535894
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="an3AxmPZ"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0F99
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 09:07:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso3547378b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696867640; x=1697472440; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U+3JOkz9MNIB/AjXQf1d+fgFmd+7/qyXYPjw/Dl3hcQ=;
        b=an3AxmPZQZABD1uRK+aZAm1IerPOmTo4A8S6xIozb7SxIYvIu+smSbuQQZbWDunBDE
         xIERw52zhcXwOADDrrqPCammE6au1DaBRJJruTSP4BrwlL0SJqj/AFxE0T/3xMFjyrsO
         Vieozisn3JZRzkRfiaGsVZT5yqbz9W6BJPPvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867640; x=1697472440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+3JOkz9MNIB/AjXQf1d+fgFmd+7/qyXYPjw/Dl3hcQ=;
        b=mr7jNd7FWo1OpfcaqZqiyJQ0tNpQjSfw8+li7nK39dgK0mU261HFAqsaAOQdTzhU12
         Orj5DnaLgJZSViUyKHDLtalwjmfo6rR/Hg2IMMiNxLI9OPyjJ2Zz0AkNYRHS494Yne1h
         l0WaoxJXybsc2n05CnyZjDZDjlV+MfvsH5xVohrPruh6PEfAWhKpqrNOkKpt/YQJG2Gu
         5JjGs8DIGjCoQFo+5vyZeFHSOmIF5mOlGHW1Yy4x0AXt3r3ZDK1ToRwECn3L6phxo4Nk
         3r/9eQNYVLD1e7Pns0LkciTQ2YS2ewee6vmshaJ0IopCXX9ebbT/nli2yqwr5WooBEF9
         ZJbg==
X-Gm-Message-State: AOJu0YwBJTvWa510tVemsTgZfHcctnYYARnAR8yGbF/ndfWFDIP1FhZL
	vfOVhOJa0HeOE7IID/dp+LSiBA==
X-Google-Smtp-Source: AGHT+IHxVEnRf0aA6FaBJyvYV0PmwQxq1Mlqp/9m+bsbe4WdfYasO6y6M2RZ8ABlDSvD8B9tNe2i5A==
X-Received: by 2002:a05:6a20:244f:b0:159:dccb:8bb4 with SMTP id t15-20020a056a20244f00b00159dccb8bb4mr16029001pzc.23.1696867640247;
        Mon, 09 Oct 2023 09:07:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b0068fb4f5f38fsm6589398pfc.30.2023.10.09.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:07:19 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:07:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] wifi: p54: Annotate struct p54_cal_database with
 __counted_by
Message-ID: <202310090906.9310CF4434@keescook>
References: <20231006201719.work.356-kees@kernel.org>
 <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xptEEHJAsrwh_oebK1_AMb+_tvLtiY8sP-Qk=Z9jXhVf7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:55:32AM -0400, Jason Andryuk wrote:
> Hi,
> 
> I randomly peeked at this patch.  Unfortunately, I am not familiar
> with the actual p54 code.
> 
> On Fri, Oct 6, 2023 at 4:17 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct p54_cal_database.
> >
> > Cc: Christian Lamparter <chunkeey@googlemail.com>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/net/wireless/intersil/p54/p54.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
> > index 3356ea708d81..770e348d1f6c 100644
> > --- a/drivers/net/wireless/intersil/p54/p54.h
> > +++ b/drivers/net/wireless/intersil/p54/p54.h
> > @@ -126,7 +126,7 @@ struct p54_cal_database {
> >         size_t entry_size;
> >         size_t offset;
> >         size_t len;
> > -       u8 data[];
> > +       u8 data[] __counted_by(entries);
> 
> This looks incorrect - I think you want __counted_by(len)?  The
> presence of entry_size made me suspicious.
> 
> >  };
> 
> This is the function that creates struct p54_cal_database:
> 
> static struct p54_cal_database *p54_convert_db(struct pda_custom_wrapper *src,
>                                                size_t total_len)
> {
>         struct p54_cal_database *dst;
>         size_t payload_len, entries, entry_size, offset;
> 
>         payload_len = le16_to_cpu(src->len);
>         entries = le16_to_cpu(src->entries);
>         entry_size = le16_to_cpu(src->entry_size);
>         offset = le16_to_cpu(src->offset);
>         if (((entries * entry_size + offset) != payload_len) ||
>              (payload_len + sizeof(*src) != total_len))
>                 return NULL;
> 
>         dst = kmalloc(sizeof(*dst) + payload_len, GFP_KERNEL);
>         if (!dst)
>                 return NULL;
> 
>         dst->entries = entries;
>         dst->entry_size = entry_size;
>         dst->offset = offset;
>         dst->len = payload_len;
> 
>         memcpy(dst->data, src->data, payload_len);
>         return dst;
> }
> 
> You can see that kmalloc is performed with `sizeof(*dst) +
> payload_len`, and payload_len is assigned to ->len.

Agreed!

> I don't read Coccinelle, but, if this patch was auto-generated, I
> wonder if the script has an error.

Yeah, I'm not sure which part went wrong. I will investigate. Thanks for
catching this!

-- 
Kees Cook
