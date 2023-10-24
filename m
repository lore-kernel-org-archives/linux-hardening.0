Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC63D399
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GiRR8zU/"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3078A6
	for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:43:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cace3e142eso31609455ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 24 Oct 2023 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183791; x=1698788591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frJVLA8q7CpIZN6bJ4cxEnaKNLHB5xpXe8qh07vj8Ko=;
        b=GiRR8zU/7JNpDaokPQXBor81wyQ0QFtHCEOBlgGjzg70V5AoiMlLJQ8rV1o3ha7UwO
         0SgZUSofr/jvqMDVKZuN8jQE4/GdCWJJgVZeo+wObU8oUNldJdFxdUj7Sy1kCO4KFVIh
         SHtsBbSdpIwO2tA1GTJ8xI64/CWUt+z/25frE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183791; x=1698788591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frJVLA8q7CpIZN6bJ4cxEnaKNLHB5xpXe8qh07vj8Ko=;
        b=GGSKeoH+NvujNe+lS9nvtoZAzCQquLh0PoRTUw7V/+bCiDTKzUtRrbHjzHnaVvoKFe
         +fEo6eZhA4t/Sm167aV7tfD8ocWYG4/GSsaSoDQ4AklOQ6/z06cYTQ9AQLi3pq6oE5sh
         +ejOe6d17yz+U63BPeFiGBjBqJ6FQquUccONrK9B/iYz6k3Gk57WOTlxdJTyUjwDjRVG
         LBoPX79ZQlp4o8n0MmOGphH8xBUD2O9w6deyrX8bUqt2EPgiwWZscxso12j+sbjB/dv3
         0jlen0R7ZpUw+9kX/vyF25+SI5W6ik/7NHWCz5oyBLUzaSPvc5iG1V74PblvZ+GF0iad
         2Hyw==
X-Gm-Message-State: AOJu0YziCmWwRuV89eLIupA9YiGtFByEBqEMfPcSddXCJGsi+ItUZ5XI
	GRDOFZVRNqR2L+7sU/VVoX49vQ==
X-Google-Smtp-Source: AGHT+IG8jAZqjr17l2IkN2BhET8ny2FkIIjuMkCIzCSC/KN1r/G1kIQNXfVGVkoHBTaZGXVDBbwJfw==
X-Received: by 2002:a17:902:f687:b0:1c9:cc88:5008 with SMTP id l7-20020a170902f68700b001c9cc885008mr13338416plg.43.1698183791215;
        Tue, 24 Oct 2023 14:43:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001bc18e579aesm7844217plg.101.2023.10.24.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:43:10 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:43:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Justin Stitt <justinstitt@google.com>,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Message-ID: <202310241442.0E90AB9@keescook>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
 <87wmvcxjdy.fsf@kernel.org>
 <90328e09-5e48-4bd0-ac67-62a104b6eb76@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90328e09-5e48-4bd0-ac67-62a104b6eb76@quicinc.com>

On Tue, Oct 24, 2023 at 07:11:51AM -0700, Jeff Johnson wrote:
> On 10/24/2023 6:03 AM, Kalle Valo wrote:
> > What about using just memcpy() to make it clear it's not really a proper
> > string:
> > 
> > arvif->u.ap.ssid_len = 4;
> > memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);
> > 
> 
> In the "changed & BSS_CHANGED_SSID" case that comes soon after this we just
> set the length and use memcpy without clearing the rest of the buffer, so
> doing the same here, as you suggest, would be consistent.

Ah, please ignore my other email asking about memcpy safety -- I'm
reading threads backwards.  :)

-- 
Kees Cook
