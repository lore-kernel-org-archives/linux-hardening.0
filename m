Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB521112
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QwyRqMqs"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10891717
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 12:07:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso129941b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Oct 2023 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696446452; x=1697051252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmNik5aKqwyxs68unDpIIbqTko6Y8PdAAVqQYM1wSd8=;
        b=QwyRqMqssGqkyrhJjcrLTlV4CoFFbxXkgVLWksi9ED+6GOCAcjGhxMK79Bb6GjfMG7
         b8BSqYg8Hqy8ENkxmPppJKXEhWefJOfZevSFO/o7FhyuDOiJF8LYAGZtAwL0uFdUaq0u
         DAPWne7rZdFV5XgDP4y9gN3egSmuUhT2Astso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446452; x=1697051252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmNik5aKqwyxs68unDpIIbqTko6Y8PdAAVqQYM1wSd8=;
        b=i1ejsyOCyzmg21dHAVHkL+1x5OQCZk27vrS16TbaYBOyUlfD7k74159kRHxll68fBY
         M8LLxhOKLQpJqi/+R1H4VwaxnJSAwEwaEtakwuKLTuegUqz0K8EJE+MErUst7XKg4dhk
         5dN2ww/xtDdZM3mA336QaVntZL1xdyjMH4g5qF3muNOI2I3zsUJ5VNwqERECgHRlcGAM
         AhnQmvSXVYzlGQ5zeDUt4kO7+ruU+E8rjFl2myclbot0t0Jf9+5N0OqTA+jZT6+Fkexf
         02NCUUZsgHhcEFq1ms9cEO9MBd9+onDQoE+xrIp5FUMMFt+UzYIhydyhW7yBsMEKFxAY
         InIw==
X-Gm-Message-State: AOJu0YxelwIzP8/yaphnWoQxohR3Pc4C0LGs/GOi+OFSHXtEEFCKxE7l
	Z/gcqUwAw2qXV7EINovrDL5q/SHu91iiGutVZco=
X-Google-Smtp-Source: AGHT+IH2zJUqh9x6F0RceLYlBv/BSl+4IpxiNNAbI4M2CvVxq/jsPEavCuV+UdE3lk2GCtDpPmoTNw==
X-Received: by 2002:a05:6a21:181:b0:13a:6bca:7a84 with SMTP id le1-20020a056a21018100b0013a6bca7a84mr3886938pzb.44.1696446451736;
        Wed, 04 Oct 2023 12:07:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006889664aa6csm3576439pfv.5.2023.10.04.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:07:31 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:07:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 62/89] pstore: convert to new timestamp accessors
Message-ID: <202310041207.A2F1A4E0@keescook>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
 <20231004185347.80880-60-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004185347.80880-60-jlayton@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 02:52:47PM -0400, Jeff Layton wrote:
> Convert to using the new inode timestamp accessor functions.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
