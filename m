Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIW98yMk"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9013E115
	for <linux-hardening@vger.kernel.org>; Fri,  1 Dec 2023 10:25:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfc3f50504so7353645ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Dec 2023 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455157; x=1702059957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orj9kF5e+hUcR28yOOxjlUg2Ej6Q6UVVNyYtII2f8D8=;
        b=EIW98yMkqWGv6NAbMULA46eyhHZ6XfRcZOPmJDtyo6oHeUqpiaZWieLOrRQ9GRjWuV
         1eC029v54Ia4Ka6R0A5OJkLS/MMt4sbEUTrs1kAd7fIU7Dswu0Qj96MOH3r0VTWIPGs7
         VVIrd+p7KJe2KwSY/prKQKEzn+Svwh3bywAzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455157; x=1702059957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orj9kF5e+hUcR28yOOxjlUg2Ej6Q6UVVNyYtII2f8D8=;
        b=uggjTEUtPe4XRZYJDdN12HQl9hlyKG3xAnDC1G1VxWnWL3BlOhQGQd6GWAlLuzSxUi
         GFBzgr2K9mQhP0Q3+n1K0vsUThSp9oHw1fx9rbxDN1gnWOvG1y+HTe1Y948YutHqD4GU
         pSFyUcfj5ZwfgvbV2VdQo449AL/dBM+74ZpLtx2+F8Rci63AlTIBX+MS/8irFI7WYh4L
         /VzLM9G0vEVHsin5PLdX2VthJgNgTQr6PQULdv9ALnffiMo09IIR2qra6Ara4g9Bb6up
         GxthQsHB5RTrOM7Uw15fuSNsSc+efXCPP0NIdIOG2UWVrR5UsUWRDN7ko7xqMdfAS2TP
         Xaqg==
X-Gm-Message-State: AOJu0Yw4OXVoPPc8XMpr9em3GGOEFFCreWdVYy6zCqxqIN7LReZNwg+N
	ScaMEimLCqttLMn2WXe9gPa8zA==
X-Google-Smtp-Source: AGHT+IEbUvlE58eT2LaLFiL7khlyUcE1aUZwyJ3/wHK55llArs7nB+pjInhr6ocqQcgHJVujAr2xgA==
X-Received: by 2002:a17:903:2302:b0:1cf:c649:61a3 with SMTP id d2-20020a170903230200b001cfc64961a3mr21194686plh.52.1701455157079;
        Fri, 01 Dec 2023 10:25:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001cfc50e5ae9sm3667469plr.78.2023.12.01.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:25:56 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Date: Fri,  1 Dec 2023 10:25:49 -0800
Message-Id: <170145514843.55310.746207226357478640.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130205607.work.463-kees@kernel.org>
References: <20231130205607.work.463-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 30 Nov 2023 12:56:08 -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] tracing/uprobe: Replace strlcpy() with strscpy()
      https://git.kernel.org/kees/c/8a3750ecf810

Take care,

-- 
Kees Cook

