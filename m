Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A263159B
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gI4e5XqT"
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD2183
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:50:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27ce160938fso293925a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696978208; x=1697583008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2ph4e3aw3myowCBYVpWGXZK0YS95STvUJ4nSeseoUo=;
        b=gI4e5XqTajQKEPi50KbEZB0HoCzzK9XziB5Cyf6iK1MfUkMOvFoz7eMMAPIsDeVuYB
         whc3Bxpkz+z7sIqHcb1JOsz+bl8lzh7oHBYpIl5EtqWKdZ0SGaCBL8vmDHQrZPviLJc+
         E1VCq6FAD6B7yqKCTDHxrgcOD96qjZVQJqgY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978208; x=1697583008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2ph4e3aw3myowCBYVpWGXZK0YS95STvUJ4nSeseoUo=;
        b=uHZX8UA/2HDkNTzzayDY2kpnuzlUcx+RoTUh8Wp59fMQoj6u+2brIdGuN54dL6qTMk
         cTr6vxzG0o3AkojrGf2n0CRnNvmBABQ0qpFPcw1T3y8bgQyQIX5rzmdChUdMgYxO8ng1
         gjjyV/NZjZ/tLOLG1d2TVPIt9HCkUjyE1ZK2wKky0o95Wsa34T7ZCjFx51Hi8AwZ77mM
         2MuykAZ6ZQWXmqHHeCsZBGZo9FJLU+MJyK3HEdrk7BQ1ZU4q8tZEO4BMQXyB6yYbo/Vm
         b7HlKbaYBnlzWPGXiCt6ijSJVC30Xj2gui1fLEJ5km7wRvtLxIp6lLQkIlBFuodXFahC
         bvdA==
X-Gm-Message-State: AOJu0YwBur9d21peuPIs5LNkSWdPAk7ZiMqCQxwMXt/iUeCRoxU1nCGh
	AVZKQPQtm/rseueaTM/PS65QCg==
X-Google-Smtp-Source: AGHT+IHMjjMmufUYlfMeoiy4n2bRLKopeW77T7iwNUpfO2rnyXe54YxZIWGrE/Lf+yAz7OEr8Uu0pQ==
X-Received: by 2002:a17:90b:4b47:b0:27c:edf7:db4a with SMTP id mi7-20020a17090b4b4700b0027cedf7db4amr4226933pjb.16.1696978208228;
        Tue, 10 Oct 2023 15:50:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bx4-20020a17090af48400b0026b76edd607sm10596603pjb.15.2023.10.10.15.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:50:07 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:50:06 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Message-ID: <202310101549.E09DE6F@keescook>
References: <ZSRXXvWMMkm7qqRW@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRXXvWMMkm7qqRW@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 01:41:18PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I realize I didn't actually send my R-b for this thread, so here it is:

Reviewed-by: Kees Cook <keescook@chromium.org>

:)

-- 
Kees Cook
